Date: Sat, 11 Jul 2020 18:48:35 +0200 (CEST)
Message-Id: <202007111648.06BGmZ2N073942@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200711093655.23686-1-arne@...1227...>
References: <20200711093655.23686-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Allow changing fallback cipher
 from ccd files/client-connect
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

The patch is trivial enough (it just allows "cipher" in ccd/ files, with
no logic changes) - it's built on the changes in the previous patches, which
makes it "just work".

Without the patch, trying to set & push a cipher from ccd/:

Jul 11 18:27:53 gentoo tap-udp-p2mp[12620]: Options error: option 'cipher' cannot be used in this context (ccd/freebsd-74-amd64)
Jul 11 18:27:55 gentoo tap-udp-p2mp[12620]: ... SENT CONTROL [freebsd-74-amd64]: 'PUSH_REPLY,...,cipher CAMELLIA-128-CBC,...,cipher AES-256-GCM' (status=1)

With the patch *and* forcing NCP on the server side by only allowing 
CAMELLIA-128-CBC:

  $ cat ccd/freebsd-74-amd64
  ncp-ciphers CAMELLIA-128-CBC
  cipher CAMELLIA-128-CBC

it will actually do that:

Jul 11 18:42:37 gentoo tap-udp-p2mp[13661]: Outgoing Data Channel: Cipher 'CAMELLIA-128-CBC' initialized with 128 bit key
Jul 11 18:42:37 gentoo tap-udp-p2mp[13661]: Incoming Data Channel: Cipher 'CAMELLIA-128-CBC' initialized with 128 bit key
Jul 11 18:42:38 gentoo tap-udp-p2mp[13661]: SENT CONTROL [freebsd-74-amd64]: 'PUSH_REPLY,...,peer-id 2,cipher CAMELLIA-128-CBC' (status=1)

(if I put "CAMELLIA and some of the AES-GCM variants" in there, I get the 
standard AES-256-GCM or AES-128-GCM variants - with no indication in the 
logs on why it doesn't want to take the cipher --> documenting this here,
so it can be found by googling: if you want "cipher" to work in CCD/ files,
you must also set "ncp-ciphers" accordingly).

Your patch has been applied to the master branch.

commit 6168f53d6b7274026d4f392a22e64524a9b264d6
Author: Arne Schwabe
Date:   Sat Jul 11 11:36:42 2020 +0200

     Allow changing fallback cipher from ccd files/client-connect

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200711093655.23686-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20281.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


