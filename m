Message-ID: <20041016182529.74188.qmail@...295...>
From: Jan Jaeger <pa3efu@...109...>
MIME-Version: 1.0
Subject: [Openvpn-devel] askpass and key-method 2
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
Date: Sat Oct 16 11:26:03 2004
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi list,
openvpn v2 now defaults to key-method 2, which means
that the key exchange now takes place over the tls
channel rather then encrypted with the private key of
the user. 
As a result of this the private key of the user is no
longer required.  The additional security that the
passphase provides is no longer there.  Anyone who has
a copy of the public key can now setup a session.
I think this is somewhat of an integrity exposure. 
Is this working as designed?

Thanks,

Jan Jaeger.


		
_______________________________
Do you Yahoo!?
Declare Yourself - Register online to vote today!
http://vote.yahoo.com

