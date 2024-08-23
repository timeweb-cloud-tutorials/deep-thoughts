import { StatusCodes } from "http-status-codes";
import { ZodSchema } from "zod";

export const parseOrThrow = async <T extends Record<PropertyKey, unknown>>(
  data: unknown,
  schema: ZodSchema<T>
): Promise<T> => {
  const parsed = await schema.safeParseAsync(data);

  if (!parsed.success) {
    throw createError({
      message: parsed.error.issues[0].message,
      statusCode: StatusCodes.UNPROCESSABLE_ENTITY,
    });
  }

  return parsed.data;
};
