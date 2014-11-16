MIME-Version: 1.0
In-Reply-To: <1416148262-20978-1-git-send-email-openvpn.list@...1114...>
References: <1416148262-20978-1-git-send-email-openvpn.list@...1114...>
Date: Sun, 16 Nov 2014 11:30:03 -0500
Message-ID: <CAJ0EP40K=APViz-h3keWhwj8JAf_K2-2NFZk9bhrzzgSpEzb1g@...278...>
From: Mike Gilbert <floppym@...594...>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

On Sun, Nov 16, 2014 at 9:31 AM, David Sommerseth
<openvpn.list@...1114...> wrote:
> From: David Sommerseth <davids@...1347...>
>
> The system() call is prone to shell expansions and provides far more
> environments variables to the executable run than what is usually
> preferred.  By moving over to exevce() shell expansions are far more
> difficult to achieve and only the OpenVPN provided environment
> variables are available.
>
> This is a response to the patch submitted to openvpn-devel ML:
> http://article.gmane.org/gmane.network.openvpn.devel/7919
>
>  v2 - Pulling it up again, fixing a few whitespace and spelling issues
>
> Signed-off-by: David Sommerseth <davids@...1347...>

Just a general comment on the error handling: Instead of printing
generic error messages when syscalls fail, wouldn't it be better to
look up the actual error description using strerror(3)? This would
include calls to malloc, fork, execve, and possibly others.

