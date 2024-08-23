<script setup lang="ts">
import {
  CREATE_THOUGHT_MAX_LENGTH,
  createThoughtSchema,
  type CreateThoughtSchema,
} from "~/schemas/thought";

import type { ThoughtFormRef } from "./types";

import { toTypedSchema } from "@vee-validate/zod";
import { useForm } from "vee-validate";

interface Props {
  error?: string;
}

defineProps<Props>();

const emit = defineEmits<{
  (event: "submit", data: CreateThoughtSchema): void;
}>();

const form = useForm({
  validationSchema: toTypedSchema(createThoughtSchema),
});

const handleSubmit = form.handleSubmit((data) => {
  emit("submit", data);
});

defineExpose<ThoughtFormRef>({
  handleResetForm: () => {
    form.resetForm();
  },
});
</script>

<template>
  <Card>
    <CardHeader class="p-5 pb-0">
      Поделитесь своей глубокой мыслью!
    </CardHeader>
    <CardContent class="p-5">
      <form
        class="gap-2 flex flex-col"
        @submit="handleSubmit"
        @keydown.enter.prevent="
          (event) => {
            if (event.shiftKey) {
              handleSubmit();
            }
          }
        "
      >
        <FormField
          v-slot="{ componentField }"
          name="name"
          :validate-on-blur="false"
        >
          <FormItem>
            <FormControl>
              <Input v-bind="componentField" placeholder="Ваше имя" />
            </FormControl>

            <FormMessage />
          </FormItem>
        </FormField>

        <FormField
          v-slot="{ componentField }"
          name="text"
          :validate-on-blur="false"
        >
          <FormItem>
            <FormControl>
              <div class="relative">
                <Textarea
                  :maxlength="CREATE_THOUGHT_MAX_LENGTH"
                  placeholder="Давайте же..."
                  v-bind="componentField"
                  class="resize-none"
                />
                <div
                  class="absolute bottom-1 right-2 flex items-center gap-2 z-5"
                >
                  {{ componentField.modelValue?.length || 0 }}/{{
                    CREATE_THOUGHT_MAX_LENGTH
                  }}
                </div>
              </div>
            </FormControl>

            <FormMessage />
          </FormItem>
        </FormField>

        <Button type="submit" class="mt-2">Отправить!</Button>

        <p v-if="error" class="text-md font-bold text-red-500">
          {{ error }}
        </p>
      </form>
    </CardContent>
  </Card>
</template>
