<script setup lang="ts">
import { type Thought } from "@prisma/client";

interface Props {
  thought: Thought;
}

defineProps<Props>();
</script>

<template>
  <Card>
    <CardHeader class="pb-4 pt-4">
      <CardTitle>
        <span class="text-sm text-muted-foreground"> От: &nbsp;</span>
        {{ thought.username }}
      </CardTitle>
    </CardHeader>
    <CardContent>
      <p class="text-lg text-muted-foreground truncate">
        {{ thought.text }}
      </p>
      <p class="text-xs mt-3 ml-auto w-fit text-muted-foreground">
        {{ new Date(thought.createdAt).toLocaleString() }}
      </p>
    </CardContent>
  </Card>
</template>
