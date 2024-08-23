import { z } from "zod";

export const CREATE_THOUGHT_MAX_LENGTH = 200;

export const createThoughtSchema = z.object({
  text: z
    .string({
      message: "Введите текст мысли",
    })
    .min(1, {
      message: "Введите что-то!",
    })
    .max(CREATE_THOUGHT_MAX_LENGTH, {
      message: `Максимальная длина текста ${CREATE_THOUGHT_MAX_LENGTH} знаков`,
    }),
  name: z
    .string({
      message: "Введите свое имя",
    })
    .max(50, {
      message: "Максимальная длина имени 50 знаков",
    }),
});

export type CreateThoughtSchema = z.infer<typeof createThoughtSchema>;
