<script setup lang="ts">
import { type Thought } from "@prisma/client";
import { type ThoughtFormRef } from "~/components/thought/form/types";
import type { CreateThoughtSchema } from "~/schemas/thought";

const error = ref("");
const formRef = ref<ThoughtFormRef>();

const {
  data: thoughts,
  status,
  refresh,
} = await useFetch<Thought[]>("/thought", {
  method: "GET",
  default: () => [],
});

const handleSubmit = async (data: CreateThoughtSchema) => {
  try {
    await $fetch("/thought", {
      method: "POST",
      body: data,
    });

    formRef.value?.handleResetForm();

    await refresh();
  } catch (err) {
    if (err instanceof Error) {
      error.value = err.message;
    }
  }
};
</script>

<template>
  <div class="max-w-md mx-auto mt-4 flex flex-col gap-2">
    <ThoughtForm ref="formRef" @submit="handleSubmit" :error="error" />

    <p class="text-destructive text-md" v-if="status === 'error'">
      {{ error }}
    </p>
    <ThoughtList :thoughts="thoughts" v-else />
  </div>
</template>
