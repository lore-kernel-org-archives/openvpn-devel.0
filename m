From: Dirk Tronienne <daniel@...297...>
Message-ID: <loom.20041020T155229-690@...171...>
Mime-Version: 1.0
Subject: [Openvpn-devel] compile statically with LZO and SSL support?
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
Date: Wed Oct 20 07:15:09 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

perhaps anybody could give me a hint who to statically compile openvpn with LZO
and SSL? I want it to run on a system where the "on-board" SSL is very limited
in case of supported ciphers and where is no possibility to install LZO.

I already found this topic:
http://article.gmane.org/gmane.network.openvpn.devel/558/match=static and
changed my Makefile according but this doesn´t seem to work for lzo - when
runing openvpn on the system without lzo theres an error complaining about
missing LZO (./openvpn: error while loading shared libraries: liblzo.so.1:
cannot open shared object file: No such file or directory).

How has the Makefile (...what else?) to be modified for LZO? Is "LDADD = -static
-lssl -lcrypto -lzo" correct?

Besides, if I use statically compiled SSL support, does this override the
already present SSL?

Thanks for any hint!

regards 
Dirk



