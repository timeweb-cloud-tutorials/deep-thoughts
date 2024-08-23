<script setup lang="ts">
import type { Thought } from "@prisma/client";

interface Props {
  thoughts: Thought[];
}

defineProps<Props>();
</script>

<template>
  <section>
    <h4
      v-if="thoughts.length === 0"
      class="text-center text-lg text-muted-foreground"
    >
      В базе нет мыслей...
    </h4>

    <ul v-else class="flex flex-col gap-2" role="list">
      <li v-for="thought in thoughts" :key="thought.id">
        <ThoughtCard :thought="thought" />
      </li>
    </ul>
  </section>
</template>
