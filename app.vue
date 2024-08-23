<script lang="ts" setup>
import { ConfigProvider } from "radix-vue";

const useIdFunction = () => useId();
</script>

<template>
  <ConfigProvider :use-id="useIdFunction">
    <NuxtLayout>
      <NuxtRouteAnnouncer />
      <NuxtPage />
    </NuxtLayout>
  </ConfigProvider>
</template>
