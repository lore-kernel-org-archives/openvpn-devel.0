Message-ID: <4CFA3D34.2030300@...68...>
Date: Sat, 04 Dec 2010 14:08:04 +0100
From: Matthias Andree <matthias.andree@...68...>
MIME-Version: 1.0
References: <1291467757-7115-1-git-send-email-matthias.andree@...68...>
In-Reply-To: <1291467757-7115-1-git-send-email-matthias.andree@...68...>
Subject: Re: [Openvpn-devel] [PATCH] Remove excess semicolon (invalid C99).
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Am 04.12.2010 14:02, schrieb Matthias Andree:
> Signed-off-by: Matthias Andree <matthias.andree@...68...>
> ---
>  misc.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

This applies to the beta2.2 branch and affects this code section:

   138
   139  static inline bool
   140  openvpn_run_script (const struct argv *a, const struct env_set *es,
const unsigned int flags, const char *hook)
   141  {
   142    char msg[256];
   143
   144    openvpn_snprintf(msg, sizeof(msg), "WARNING: Failed running command
(%s)", hook);
   145    return openvpn_execve_check(a, es, flags | S_SCRIPT, msg);
   146  };
   147

Evidently this is a function definition and hence not to be followed by a
semicolon.  Most compilers will accept it, but try gcc -Wall -Wextra -pedantic
-std=c99 and see what you get :)

-- 
Matthias Andree

