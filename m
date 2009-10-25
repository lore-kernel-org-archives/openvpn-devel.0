Date: Sun, 25 Oct 2009 23:13:01 +0300
From: Victor Wagner <vitus@...1066...>
Message-ID: <20091025201301.GA10166@...1066...>
References: <20091023142219.GA30874@...1066...> <4AE3580C.7080604@...41...>
MIME-Version: 1.0
In-Reply-To: <4AE3580C.7080604@...41...>
Subject: Re: [Openvpn-devel] Character classes in the tls-verify script
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On 2009.10.24 at 13:39:56 -0600, James Yonan wrote:

> Victor Wagner wrote:
> > I've found out that string_mod family of function do very bad job
> > with certificates with cyrillic characters in the subject.
> > 
> > As of OpenVPN 2.1_rc19 class CC_PRINT is determined by function
> > isprint from ctype.h, which does wrong job if there was no setlocale
> > call (and there is no setlocale call in the OpenVPN).
> > 
> 
> Can you submit a patch (as an email attachment) with this fix?
> 
> My only concern would be if there are ways an attacker could use chars 
> that are >= 128 to attack a shell or server-side auth script.
> 
> I think it would be better to have this turned off by default, but have
> an option to enable it, like the no-name-remapping option in 2.1.

If this option wouldn't conflict with script-security 3 system (as
"no-name-remapping" does, it would be nice.

Tomorrow I'd cut this patch out of my patch to openvpn 2.1rc19
It would require some time, because I now use OpenVPN with following
addititonal functionality:
1. Support for non-HMAC packet authentication algorithm (requires
OpenSSL 1.0, where support for non-HMAC MAC algorithms appeared)
2. Support for loading private keys from crypto hardware module via
OpenSSL engine API, not PKCS11 API, using other engine than set by
engine configuration parameter.
3. Export of certificate extension subjectAltName to scripts.
4. Support for CC_MSB character class.


