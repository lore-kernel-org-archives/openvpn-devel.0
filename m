Message-ID: <5481FBE3.4050600@...1856...>
Date: Fri, 05 Dec 2014 19:39:31 +0100
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <1416148262-20978-1-git-send-email-openvpn.list@...1114...>
In-Reply-To: <1416148262-20978-1-git-send-email-openvpn.list@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] down-root plugin: Replaced system()
 calls with execve()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 16-11-14 15:31, David Sommerseth wrote:
> The system() call is prone to shell expansions and provides far more
> environments variables to the executable run than what is usually
> preferred.  By moving over to exevce() shell expansions are far more
> difficult to achieve and only the OpenVPN provided environment
> variables are available.

My compiler has some nitpicks (see below), but otherwise ACK. Code looks
sane and works for me.

> @@ -453,18 +435,16 @@ openvpn_plugin_abort_v1 (openvpn_plugin_handle_t handle)
>   * Background process -- runs with privilege.
>   */
>  static void
> -down_root_server (const int fd, char *command, const char *argv[], const char *envp[], const int verb)
> +down_root_server (const int fd, char * const *argv, char * const *envp, const int verb)
>  {
>    const char *p[3];
> -  char *command_line = NULL;
> -  char *argv_cat = NULL;
>    int i;

You can remove even more code:

down-root.c:440:15: warning: unused variable 'p' [-Wunused-variable]
  const char *p[3];
              ^
down-root.c:441:7: warning: unused variable 'i' [-Wunused-variable]
  int i;
      ^

-Steffan

