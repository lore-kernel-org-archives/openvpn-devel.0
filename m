Date: Thu, 5 Feb 2009 18:02:43 +0200 (EET)
From: upb <upb@...1192...>
Message-ID: <alpine.DEB.1.10.0902051757590.7502@...1193...>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-416440086-1233849764=:7502"
ReSent-To: openvpn-devel@lists.sourceforge.net
ReSent-Message-ID: <alpine.DEB.1.10.0902051843380.9352@...1193...>
Subject: [Openvpn-devel] [PATCH] certificate subject parsing bug in
 extract_x509_field_ssl. against 2.1_rc7
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net
Cc: upbupb@...277...

--8323329-416440086-1233849764=:7502
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII

This bug causes cert subjects where common name is the first component of 
the subject, to be parsed incorrectly, resulting in no common name being 
returned at all.

Observed effects include incorrect client configuration being read (the 
UNDEF one) etc.

Patch is attached.

Regards,
upb

League of local jewish enterpreneurs.
--8323329-416440086-1233849764=:7502
Content-Type: TEXT/x-diff; name=openvpn.certificate.subject.parsing.patch
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.DEB.1.10.0902051802430.7502@...1193...>
Content-Description: 
Content-Disposition: attachment;
	filename=openvpn.certificate.subject.parsing.patch

LS0tIHNzbC5jLmJ1Z2d5CTIwMDktMDItMDUgMTc6NTQ6MzIuMDAwMDAwMDAw
ICswMjAwDQorKysgc3NsLmMJMjAwOS0wMi0wNSAxNzo1NTowOS4wMDAwMDAw
MDAgKzAyMDANCkBAIC00MDIsNyArNDAyLDcgQEANCiAgIGRvIHsNCiAgICAg
bGFzdHBvcyA9IHRtcDsNCiAgICAgdG1wID0gWDUwOV9OQU1FX2dldF9pbmRl
eF9ieV9OSUQoeDUwOSwgbmlkLCBsYXN0cG9zKTsNCi0gIH0gd2hpbGUgKHRt
cCA+IDApOw0KKyAgfSB3aGlsZSAodG1wICE9IC0xKTsNCiANCiAgIC8qIE5v
dGhpbmcgZm91bmQgKi8NCiAgIGlmIChsYXN0cG9zID09IC0xKQ0K

--8323329-416440086-1233849764=:7502--


