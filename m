Message-ID: <ec8fb727-3db8-4ca5-b4ce-b94adbce53e9@...1227...>
Date: Mon, 3 Nov 2025 11:12:32 +0100
MIME-Version: 1.0
References: <CAOh3LPOey9b8wdPv7NeHqZopWgw3f0c-cXsZ+ozWZ7nzyn7s2Q.ref@...278...>
 <CAOh3LPOey9b8wdPv7NeHqZopWgw3f0c-cXsZ+ozWZ7nzyn7s2Q@...278...>
Content-Language: en-GB
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <CAOh3LPOey9b8wdPv7NeHqZopWgw3f0c-cXsZ+ozWZ7nzyn7s2Q@...278...>
Subject: Re: [Openvpn-devel] One more program crash that I happened to
 observe and catch in GDB - potential free/malloc bug?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Jon Chiappetta <root@...2904...>, openvpn-devel@lists.sourceforge.net, Gert Doering <gert@...1296...>

Am 02.11.25 um 20:52 schrieb Jon Chiappetta via Openvpn-devel:
> Hi Gert and devs,
> 
> During my experimentation with this dual mode, I've had to go through a 
> lot of the code in the ssl.c library file. While I was tracing and 
> testing my modifications, I think I found another potential crash path 
> but I'm also not sure if it was my modifications or if this is indeed a 
> bug potentially.
> 
> This was the GDB backtrace I was able to capture during my own modified 
> testing:
> 
> 
> 
> Thread 8 "openvpn" received signal SIGSEGV, Segmentation fault.
> [Switching to Thread 0x7fffdffff6c0 (LWP 638500)]
> 0x00007ffff74add55 in __GI___libc_free (mem=0x2) at ./malloc/malloc.c:3375
> warning: 3375   ./malloc/malloc.c: No such file or directory
> (gdb) Quit
> (gdb) bt
> #0  0x00007ffff74add55 in __GI___libc_free (mem=0x2) at ./malloc/ 
> malloc.c:3375
> #1  0x0000555555564be1 in free_buf (buf=buf@...1851...=0x7fffd40068b0) at 
> buffer.c:186
> #2  0x00005555555e1d04 in key_state_free (ks=ks@...1851...=0x7fffd40065d0, clear=clear@...1851...=false) at ssl.c:928


void
key_state_ssl_free(struct key_state_ssl *ks_ssl)
{
     if (ks_ssl->ssl)
     {
#ifdef BIO_DEBUG
         bio_debug_oc("close ssl_bio", ks_ssl->ssl_bio);
         bio_debug_oc("close ct_in", ks_ssl->ct_in);
         bio_debug_oc("close ct_out", ks_ssl->ct_out);
#endif
         BIO_free_all(ks_ssl->ssl_bio);
         SSL_free(ks_ssl->ssl);
     }
}

This method does not have a free_buf that is in your backtrace. So it 
looks more like it is only in your modified version.

In general you have to a bit careful. Often the code assumes that the 
struct are initlised with zero, which also makes pointers and so on 
NULL. And the original method here is also in this pattern and checking 
if (ks_ssl->ssl) before doing anything. The pattern that free is used on 
something that is not initialised (but only is all zero) is a quite a 
common pattern in OpenVPN.

Arne

