Message-ID: <20040408043145.35799.qmail@...197...>
From: gary ng <garyng2000@...109...>
MIME-Version: 1.0
Subject: [Openvpn-devel] key management ?
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
Date: Thu Apr  8 14:46:05 2004
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

Openvpn is moving nicely in feature for large scale
deployment.

I am wondering if there is already plan to make the
key management more suitable for this kind of
deployment.

AFAIK, currently the cert can only be signed by one
root CA. However, this is usually not how these public
key based authentication is used in corporations(based
on my experienced with Lotus Notes). Usually, the root
CA of an organisation is well guarded and is only used
to sign intermediate CAs(can be multiple level) which
are then delegated for actual end node cert signing.
This has the advantage that if certain CAs are
compromised, they can be moved to CRL making any
future cert signed by then being rejected. This is
also useful for inter-organisational situation when
such confidential communication is necessary. 

Another nice to have feature is to associate(or limit)
the remote IPs based on certificates. 



__________________________________
Do you Yahoo!?
Yahoo! Small Business $15K Web Design Giveaway 
http://promotions.yahoo.com/design_giveaway/

