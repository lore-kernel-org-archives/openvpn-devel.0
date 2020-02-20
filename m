From: David Sommerseth <davids@...515...>
Date: Thu, 20 Feb 2020 19:19:51 +0100
Message-Id: <20200220181951.7603-7-davids@...515...>
In-Reply-To: <20200220181951.7603-1-davids@...515...>
References: <20200220181951.7603-1-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH applied] Fix possible access of
 uninitialized pipe handles
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net, Selva Nair <selva.nair@...277...>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Your patch has been applied to the master branch

commit 32723d29b2775d63d3fe329d017e7a08e0cdcb72
Author: Selva Nair
Date:   Wed Feb 19 20:56:43 2020 -0500

     Fix possible access of uninitialized pipe handles

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <1582163803-3342-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19480.html
     Signed-off-by: David Sommerseth <davids@...515...>


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJeTsejAAoJEIbPlEyWcf3ysT0QALdZe2FV06fMaBp4oljUr2AZ
H/bViP11W21UpcyiHDAGR2YsjOf+Uzrg7z5S/eEmAdIk6TdymsOlEwLkxOwog9qd
ve5EQp2Zpwnnugz5YPdAsnXt5BY6FwfEA3roeU20s4O+dnovuHxmquDmZr8MosXD
b2Zj+OTaQbKlggqtpc7J0uaVWirV3EPK9sE86VGHBp43di2DzA+OlJBawrzqOJj8
9XTC5VPgncFsfQ5IxwnlaW0JkFJxQAceTEstGbkzPaf17o4uot7eW7xmeiA7z8A5
MAxJj8gM0sTgQx20hn0il9tqn9k6UazRLyQ+KIZpK4yeRyZRNRXiR9VhjozmVu5T
y36IwDhghoLnJGHwcpLoys0ZLEP43RLhZRZ2ez6/8A/06+NsFMWkUmJnlaPmGuOP
iJqFoQBixnyWxWbnN5vuYGeem5x9CBF0WS7gk6wyP36yzmFAgbie0NgbC25sXE7L
0iJ5ZMzuKFcrik3NosNeqr6wl4yVeTXmRDxGoCaImBo1UD3GIo7z/j3+mnSl6HpC
qaEpYrxrXxH6oV518QZLC5NWR4JtlEalXml46KnH8vaKETR2+1Qh/thCEfprkxC+
D3SsPsGfuMHjRr7wyuBczpdrOlUMRlkO4D2RfBdPPhtr4W5jlWS/1KughzXiFsSm
ITg12xX4ms+SQ1Sf5XXf
=IIso
-----END PGP SIGNATURE-----

