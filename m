MIME-Version: 1.0
In-Reply-To: <1448852638-2644-1-git-send-email-fukawi2@...277...>
References: <1448852638-2644-1-git-send-email-fukawi2@...277...>
From: Steffan Karger <steffan@...1856...>
Date: Tue, 15 Dec 2015 20:16:33 +0100
Message-ID: <CAA1AbxKxit-x3qb4Ybbqfqrrszn6Qkd+u5K98xDxkm3wQcB6UA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Use example.com to improve clarity of
	documentation
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
To: Phillip Smith <fukawi2@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi Philip,

On Mon, Nov 30, 2015 at 4:03 AM, Phillip Smith <fukawi2@...277...> wrote:
> This patch uses the generic "host1.example.com" and "host2.example.com" to
> replace the current "may" and "june" hostname examples. Generic names chosen
> rather than other names like "server"/"client" or "head-office"/"remote-office"
> etc which may create other unintended or implicit meanings to the reader.
> The example.com domain is set aside defined by IANA for use as documentation
> examples. Refer to: http://www.iana.org/domains/reserved
> Using this well-known domain makes comprehension of documentation easier.

Feature-ACK to using example.com (or .net, or .org, I don't care).

> @@ -6741,12 +6742,11 @@ option to use OpenVPN's default key renegotiation interval of one hour.
>  .SS Routing:
>  Assuming you can ping across the tunnel,
>  the next step is to route a real subnet over
> -the secure tunnel.  Suppose that may and june have two network
> -interfaces each, one connected
> -to the internet, and the other to a private
> -network.  Our goal is to securely connect
> -both private networks.  We will assume that may's private subnet
> -is 10.0.0.0/24 and june's is 10.0.1.0/24.
> +the secure tunnel.  Suppose that On host1.example.com and host2.example.com
> +have two network interfaces each, one connected to the internet, and the other
> +to a private network.  Our goal is to securely connect both private networks.
> +We will assume that host1.example.com's private subnet is 10.0.0.0/24 and
> +host2.example.com's is 10.0.1.0/24.

An extra 'On' seems to have slipped in there.

Finally, we should probably do the same for the sample keys, and the
gen-sample-key.sh script.  You could either do that in a new version
of your patch, or I will send a follow-up patch to do so.  Both are
fine with me.

-Steffan

