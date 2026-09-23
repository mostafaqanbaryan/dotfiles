export const NotificationPlugin = async ({ $, client }) => {
  return {
    event: async ({ event }) => {
      if (event.type !== "session.idle") return;

      const sessionID = event.properties.sessionID;

      const session = await client.session.get({
        path: { id: sessionID },
      });

      let tmuxName = "OpenCode";

      if (process.env.TMUX) {
        tmuxName = (
          await $`tmux display-message -p '#{session_name}'`.text()
        ).trim();
      }
      await $`notify-send "${tmuxName} - ${session.data?.title ?? ""}" "Job finished"`;
    },
  };
};
