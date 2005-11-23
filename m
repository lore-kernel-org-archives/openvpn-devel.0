From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] [patch] Typo in manage.c causes compile failure
In-Reply-To: <20051122193420.GQ32660@...507...>
Message-ID: <Pine.LNX.4.58.0511232246020.7087@...41...>
References: <20051122193420.GQ32660@...507...>
MIME-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Nov 23 21:48:01 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: David Stipp <dstipp@...507...>
Cc: openvpn-devel@lists.sourceforge.net

On Tue, 22 Nov 2005, David Stipp wrote:

> Hi all,
> 
> In OpenVPN 2.0.5, the following patch is necessary to compile manage.c
> with Sun Studio 9. Without it, the resulting symbol will be undefined.
> 
> ********************************************************************************
> --- manage.c.orig       2005-11-01 05:06:11.000000000 -0600
> +++ manage.c    2005-11-22 13:14:00.420287000 -0600
> @@ -1564,7 +1564,7 @@
> 
>  #endif
> 
> -inline bool
> +static inline bool
>  man_standalone_ok (const struct management *man)
>  {
>    return !man->settings.management_over_tunnel && man->connection.state != MS_INITIAL;
> ********************************************************************************
> 
> There are 'static inline bool's all over the code, but only this one
> particular 'inline bool'.  Perhaps it was just a mistype.
> 
> Please CC me on any additional correspondence as I am not on the mailing
> list.

Indeed, this appears to be a typo.  I will fix for 2.0.6 and the 2.1 beta 
series.

James


