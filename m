From: William Preston <openvpn@...275...>
MIME-Version: 1.0
Message-Id: <200604271856.16445.openvpn@...275...>
Subject: [Openvpn-devel] UTF-8 support for passwords
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
Date: Thu Apr 27 09:57:02 2006
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net


Hi list,

I've had a couple of users who weren't able to authenticate against a proxy
because they had a non-ascii password (=FC u-umlaut in both cases).

I suggested they change it - but I could envision circumstances where this
isn't possible :-)


-so I'd like to do the following;

# document the default character set as UTF-8 for passwords
# remove the sanity checking in get_user_pass()
# fix the unicodize() function

I'm willing to bet this will break something however...

Does anyone see problems with this, or have suggestions?


William

