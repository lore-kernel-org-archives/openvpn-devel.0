From: ABONYI Balint <abi@...200...>
Message-ID: <c6882f$cbk$1@...165...>
Mime-Version: 1.0
Subject: [Openvpn-devel] using tokens
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
Date: Fri Apr 23 09:50:02 2004
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

We have some customers, who would like to use OPENVPN (mostly under 
windows), but at the same time they want to store all CA's at usb 
tokens, are there any plans to enable this? The windows CryptoAPI can 
get the keys from the storage and after some converting you can feed the 
data to OPENSSL, but it needs some changes. Under Linux it could be done 
using opensc (www.opensc.org). Is there any possibility that this will 
be done in the near future?

    Balint


