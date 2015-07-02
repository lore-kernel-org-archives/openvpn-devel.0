MIME-Version: 1.0
In-Reply-To: <55950ACC.1000909@...1147...>
References: <55950ACC.1000909@...1147...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Thu, 2 Jul 2015 05:16:01 -0700
Message-ID: <CAEsd45S8h+Z4tgLh2uDiMbxW+Q2VzLdPzu6jjViUwmVOC0=cUA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Add TFTP and WPAD DHCP options
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
To: Jan Just Keijser <janjust@...1147...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Thu, Jul 2, 2015 at 2:56 AM, Jan Just Keijser <janjust@...1147...> wrote:
> Attached is the patch to add the TFTP and WPAD DHCP options. The patch
> is based on openvpn 2.3.7 as I did not know how to do a windows mingw
> build of the git version ...
> The patch was tested on Windows XP 32bit and Windows 7sp1 64bit.
> A 64bit windows binary can be found @
> http://www.nikhef.nl/~janjust/openvpn-2.3.7-dhcp-win64.exe
>
> Signed-off-by: Jan Just Keijser <janjust@...1147...>

<snip>

NAK, but easy to fix (I think). Three small problems are described below.

> @@ -6153,6 +6157,14 @@
>         {
>           o->disable_nbt = 1;
>         }
> +         else if (streq (p[1], "TFTP") && p[2])
> +       {
> +         o->tftp = p[2];
> +       }
> +         else if (streq (p[1], "WPAD") && p[2])
> +       {
> +         o->wpad_url = p[2];
> +       }
>        else
>         {
>           msg (msglevel, "--dhcp-option: unknown option type '%s' or
> missing parameter", p[1]);

1. Shouldn't "dhcp_option_address_parse()" be used to set o->tftp and
o->wpad_url? (In the code just before this, it is used for NTP, WINS,
etc.)


> --- openvpn-2.3.7/src/openvpn/tun.c     2015-06-08 08:16:35.000000000 +0200
> +++ /tmp/build-x86_64/openvpn-2.3.7/src/openvpn/tun.c   2015-07-02
> 11:30:19.979658823 +0200
> @@ -4692,6 +4692,23 @@
>      buf_write_u8 (buf,  4);  /* length of the vendor specified field */
>      buf_write_u32 (buf, 0x002);
>    }
> +
> +    write_dhcp_str (buf, 66, o->tftp, &error);
> +    write_dhcp_str (buf, 150, o->tftp, &error);
> +
> +  /* IE6 seems to requires an extra charachter at the end of the URL */

<snip>

2. This should be "character", not "charachter".

3. This should be documented on the man page, too.

