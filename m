Message-ID: <5481FD9D.70901@...1856...>
Date: Fri, 05 Dec 2014 19:46:53 +0100
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <1416262460-9158-1-git-send-email-openvpn.list@...1114...>
In-Reply-To: <1416262460-9158-1-git-send-email-openvpn.list@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] down-root: Improve error messages
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

On 17-11-14 23:14, David Sommerseth wrote:
> If down-root fails it will now use warn() to provide some more information
> about what went wrong, by retrieving the error message via errno.

Here too a small nitpick from the compiler (forgot to include err.h),
but otherwise ACK.

down-root.c:164:4: warning: implicit declaration of function 'warn'
      is invalid in C99 [-Wimplicit-function-declaration]
          warn ("DOWN-ROOT: daemonization failed");
          ^
down-root.c:239:5: warning: implicit declaration of function 'err' is
      invalid in C99 [-Wimplicit-function-declaration]
    err(127, "DOWN-ROOT: Failed execute: %s", argv[0]);
    ^

-Steffan

