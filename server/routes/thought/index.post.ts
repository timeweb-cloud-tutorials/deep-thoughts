import { createThoughtSchema } from "~/schemas/thought";
import { db } from "~/server/db";

export default defineEventHandler(async (event) => {
  const body = await readBody(event);

  const bodyParsed = await parseOrThrow(body, createThoughtSchema);

  const thought = await db.thought.create({
    data: {
      username: bodyParsed.name,
      text: bodyParsed.text,
    },
  });

  return thought;
});
