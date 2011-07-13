Date: Wed, 13 Jul 2011 19:38:16 +0300
From: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@...124...>
Message-ID: <20110713163816.GT32373@...1281...>
MIME-Version: 1.0
Subject: [Openvpn-devel] openvpn support for challenge-response otp
	(user+pass+otp)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hello,

Has anyone implemented challenge-response support to openvpn and openvpn gui?

I'd like to be able to authenticate openvpn users so that all these are required:
	1) x509 certificate
	2) username + password
	3) one time password (otp)

So after the user gets user+pass prompt, and the password is verified to be correct, 
the user will get another prompt asking for a one time password.

OTP can be delivered as sms to the user, or it could be rsa securid value from the token, or something else..

Openvpn gui would need to be able to present additional prompt after the usual user+pass prompt..
For example openssh supports challenge-response, so user+pass+otp is possible with it.

Thoughts/plans?

-- Pasi


