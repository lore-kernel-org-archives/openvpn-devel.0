From: Neil Brown <neilb@...253...>
MIME-Version: 1.0
Message-ID: <16646.13395.513312.673666@...253...>
In-Reply-To: message from James Yonan on Tuesday July 27
References: <16645.47913.650600.619643@...253...>
	<twig.1090917161.17087@...41...>
Subject: [Openvpn-devel] Re: [PATCH - 2 of 4]  minimal change to PUSH_DEFINED
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
Date: Tue Jul 27 03:55:02 2004
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net

On Tuesday July 27, jim@...41... wrote:
> PUSH_DEFINED is currently unused, so overall I don't have any problem with
> this.  Probably when something gets written that needs PUSH_DEFINED, the
> subtletes of how it should operate will become more apparent.
> 

It was used in beta6 which is what I was working on when I found the
need for this patch. 
In options_string, it read:
  if (tt && !PUSH_DEFINED(o) && !PULL_DEFINED(o))
    {
      const char *ios = ifconfig_options_string (tt, remote, o->ifconfig_nowarn, gc);
      if (ios && strlen (ios))
	buf_printf (&out, ",ifconfig %s", ios);
    }

beta7 reads
  if (tt && o->mode == MODE_POINT_TO_POINT && !PULL_DEFINED(o))
    {
      const char *ios = ifconfig_options_string (tt, remote, o->ifconfig_nowarn, gc);
      if (ios && strlen (ios))
	buf_printf (&out, ",ifconfig %s", ios);
    }

which may well be fixing the same problem that I saw.

NeilBrown

