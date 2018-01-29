MIME-Version: 1.0
From: Selva Nair <selva.nair@...277...>
Date: Mon, 29 Jan 2018 13:09:12 -0500
Message-ID: <CAKuzo_jVbyE3kQkgT1aYgMSK-YGm2Ho=Evbsrck5Y4mNwAsKmQ@...278...>
Subject: [Openvpn-devel] test latest binary on vista
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>, "openvpn users list (openvpn-users@lists.sourceforge.net)" <openvpn-users@lists.sourceforge.net>

(Cross posting to users and devel)

Hi,

2.4.x needs to support, Vista, isn't it?

Can anyone please latest 2.4 release branch on Windows Vista using an
RSA certificate in Windows cert store (using --cryptoapicert option) ?

Need to be built with openssl 1.1. Not sure the snapshots are built that way..
https://build.openvpn.net/downloads/snapshots/

The recent changes to cryptoapi uses CNG api which is supposedly
supported on Vista but some testing would be useful. I no longer have
access to a Vista machine.

Thanks,

Selva

