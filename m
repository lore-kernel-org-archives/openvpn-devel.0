Message-Id: <200304171305.h3HD5H104291@...41...>
Subject: Re: [Openvpn-devel] Re: New beta available + progress update
From: "James Yonan" <jim@...41...>
In-Reply-To: <20030417121516.GA19479@...33...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Thu Apr 17 06:06:13 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Matthias Andree <ma+ovpnd@...31...>, openvpn-devel@lists.sourceforge.net

Matthias Andree <ma+ovpnd@...31...> said:

> On Thu, 17 Apr 2003, James Yonan wrote:
> 
> > A better alternative (orginally suggested by you) is to avoid fragmenting in
> > the first place by bouncing back ICMP_DEST_UNREACH/ICMP_FRAG_NEEDED to the TUN
> > device.  This won't work on TAP devices because the ethernet MTU is fixed
at 1500.
> > 
> > Unfortunately (or fortunately depending on your perspective), my network
> > connections are not broken enough to benefit from the FRAGMENT_ENABLE stuff
> > just yet, so I can't really test it properly.
> 
> Well, the peer that was behind an overloaded 1 Mbps 2 km radio link has
> now moved and has become a V.34+ modem link (33k6 bps), with
> corresponding effects on the MTU. I wonder if running a local pppd pair
> with properly MTU can be used to figure if fragmentation works, but
> there's yet have to be someone who drops individual fragments (unless
> gremlin mode does it already) for real testing.

Gremlin tests that the dynamic MTU/bandwidth algorithm can survive, but
doesn't really help when it comes to tuning the algorithm for optimality in
real-world conditions.

The nice part about a radio link is that it is probably under your control,
meaning that you can ensure that ICMPs get properly passed.  This allows path
MTU discovery to work and therefore solves a lot of the harder problems.

In this case, the FRAGMENT_ENABLE code would take the Path MTU hint from the
OS rather than trying to figure it out empirically by trial-and-error.  The
current FRAGMENT_ENABLE code knows how to get the PMTU from Linux, but still
needs code for other OSes.

> OTOH, fragmenting links also have a natural impact on the packet loss:
> if you assume 10% packet loss on the transport layer (that transports
> the fragment), and you fragment a TAP packet of 1500+ bytes into 3 of
> approx 500 bytes (say, MTU=552), the effective packet loss for TCP or
> something is much higher: it takes losing a single fragment to
> retransmit, so the effective packet loss will come out as 27% (not
> taking burst loss into account).

Good point.
 
> I also have another patch to fix prototype warnings:

Merged.

James

> 
> diff -u thread.h thread.h
> --- thread.h	17 Apr 2003 10:51:21 -0000
> +++ thread.h	17 Apr 2003 11:05:38 -0000
> @@ -118,17 +118,17 @@
>  #define MUTEX_UNLOCK(lock)
>  
>  static inline void
> -thread_init()
> +thread_init(void)
>  {
>  }
>  
>  static inline void
> -thread_cleanup()
> +thread_cleanup(void)
>  {
>  }
>  
>  static inline int
> -thread_number()
> +thread_number(void)
>  {
>    return 0;
>  }
> @@ -139,7 +139,7 @@
>  }
>  
>  static inline void
> -work_thread_join ()
> +work_thread_join (void)
>  {
>  }
>  
> 
> -- 
> Matthias Andree
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 



-- 




