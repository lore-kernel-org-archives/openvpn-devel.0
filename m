Message-ID: <53581D43.6060501@...1856...>
Date: Wed, 23 Apr 2014 22:06:27 +0200
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <53572C4E.7010701@...1901...>
	<20140423081058.GJ16637@...1296...>	<53579C5D.5000902@...1435...>
	<5357DDFC.2010401@...1901...>
In-Reply-To: <5357DDFC.2010401@...1901...>
Subject: Re: [Openvpn-devel] Progress on Version negotiation
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

Hi,

On 23-04-14 17:36, Timothe Litt wrote:
> Just to confirm that the issue is 1.2, not the negotiation:
> 
> I added an unconditional
>       sslopt |= SSL_OP_NO_TLSv1_2;
>  in tls_ctx_set_options.
> 
> With this (and the context initialized to SSL_v23_*_method, so we
> negotiate), the tunnel comes up.
> Without it, the tunnel does not come up.
> 
> So it is the use of 1.2 that is the issue, not how it is selected.

Good, this gives us a better starting point (and can make a temporary
fix less intrusive).

> I generated a matching pair of traces of the failure (client and server)
> & posted a summary.
> 
> Let me know if you would like the full traces.

Yes please. You seem to have isolated the relevant parts, but just maybe
I can spot something.

> This is 100% reproducible here, so let me know if you need more
> instrumentation. (However, I can't build a windows client, so if that's
> necessary, you'll have to build it for me to run.)

I've been trying to reproduce the error. I grabbed my spare pi from the
desk drawer and built 2.3.3 from sources like you describe in #385. I
fired up a Windows 8.1 VM, and installed OpenVPN 2.3.3-I002 (x64). This
setup however happily connects with TLSv1.2. It's hard to get a hold on
this one...

-Steffan

