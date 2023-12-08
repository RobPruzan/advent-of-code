import { pipe } from "fp-ts/function";
import * as O from "fp-ts/Option";
import * as S from "fp-ts/string";
import * as A from "fp-ts/ReadonlyArray";

const path = "input.txt";
const file = Bun.file(path);
const stringToIntMapper = (el: string) =>
  Number(
    el
      .trim()
      .replace(" ", "")
      .split("")
      .filter((char) => !Number.isNaN(Number(char)))
      .join("")
  );

pipe(
  await file.text(),
  S.split("\n"),
  A.mapWithIndex((id, line) =>
    pipe(
      line,
      S.split(/[,:;]/),
      A.map((el) => {
        if (el.includes("Game")) {
          return {
            type: "id" as const,
            value: stringToIntMapper(el),
          };
        }
        if (el.includes("red")) {
          return {
            type: "red" as const,
            value: stringToIntMapper(el),
          };
        }
        if (el.includes("blue")) {
          return {
            type: "blue" as const,
            value: stringToIntMapper(el),
          };
        }
        if (el.includes("green")) {
          return {
            type: "green" as const,
            value: stringToIntMapper(el),
          };
        }
        return { type: "never" as const };
      }),
      (arr) => {
        const [info, ...rest] = arr;
        return [
          info,
          { type: "never" as const },
          { type: "never" as const },
          ...rest,
        ];
      },
      A.chunksOf(3),
      A.map((chunk) => {
        const isGameItemValidArr = chunk.map((item) => {
          switch (item.type) {
            case "id": {
              return item.value;
            }
            case "blue": {
              return item.value <= 14;
            }
            case "green": {
              return item.value <= 13;
            }
            case "red": {
              return item.value <= 12;
            }
            case "never": {
              return false;
            }
          }
        });
        return isGameItemValidArr;
      }),
      (arr) => arr.flat(1),
      (arr) => {
        const [id, never1, never2, ...bools] = arr;
        const inValid = bools.some((e) => !Boolean(e));
        if (inValid) {
          return [];
        }
        return [id as number];
      }
    )
  ),
  (arr) => arr.flat(),
  A.reduce(0, (acc, curr) => acc + curr!),
  console.log
);

export {};
