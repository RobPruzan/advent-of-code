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
      (arr) =>
        arr.reduce(
          (prev, curr) => {
            const { type, value } = curr;

            switch (type) {
              case "blue": {
                return { ...prev, blue: Math.max(value, prev.blue) };
              }
              case "red": {
                return { ...prev, red: Math.max(value, prev.red) };
              }
              case "green": {
                return { ...prev, green: Math.max(value, prev.green) };
              }
              case "id": {
                return { ...prev, id: value };
              }
              default: {
                return prev;
              }
            }
          },
          { id: -1, red: -1, blue: -1, green: -1 }
        )
    )
  ),
  (arr) =>
    arr.reduce((prev, curr) => prev + curr.blue * curr.green * curr.red, 0),

  console.log
);

export {};
