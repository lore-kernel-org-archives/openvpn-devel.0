Message-Id: <1666983897684.4024046017.1513116668@...68...>
From: Marc Becker <becm@...68...>
Date: Fri, 28 Oct 2022 19:19:17 +0000
In-Reply-To: <Y1wDvf7k2GhlOesC@...2685...>
References: <Y1wDvf7k2GhlOesC@...2685...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] 2.5.8 release
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

In relation to PKCS#11 improvements I was hoping to get
https://github.com/OpenSC/pkcs11-helper/pull/59
done by now to make external DLLs easier to use.

Seems to be some lines in pkcs11-helper and a transition from
pkcs11h_addProvider()
to a combination to
pkcs11h_registerProvider()/pkcs11h_setProviderProperty()
and maybe just the set appropriate flags based on abspath().

But sadly I did not get around to do it, too much day work.


Regards,
Marc

