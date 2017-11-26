References: <20171111161122.30087-1-gert@...2298...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <c52b8359-0fb3-4b8b-4fa2-ac25ae31d559@...1856...>
Date: Sun, 26 Nov 2017 11:02:01 +0100
MIME-Version: 1.0
In-Reply-To: <20171111161122.30087-1-gert@...2298...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 1/2] manpage: improve description of
 --status and --status-version
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

A very welcome improvement of the man page, but one consideration:

On 11-11-17 17:11, Gert van Dijk wrote:
> Signed-off-by: Gert van Dijk <gert@...2298...>
> ---
>  doc/openvpn.8 | 31 ++++++++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/doc/openvpn.8 b/doc/openvpn.8
> index a4189ac2..267497fd 100644
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -2452,12 +2452,37 @@ seconds.
>  Status can also be written to the syslog by sending a
>  .B SIGUSR2
>  signal.
> +
> +With multi\-client capability enabled on a server, the status file includes a

Although 'server mode' is somewhat ambiguous, that is what most of the
man page uses.  So I'd suggest to change this to 'In server mode, ...'.

(With 'server mode' we mean '--mode server' as described in the 'Server
mode' section, but some might interpret 'tls-server' or 'tcp-server' as
a 'server mode'.)

-Steffan

