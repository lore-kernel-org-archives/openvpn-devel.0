From: mts.spb.suxx@...450...
Reply-To: mts.spb.suxx@...450...
Message-ID: <1724438204.20050904221241@...450...>
Subject: Re[2]: [Openvpn-devel] The use of lzo if OpenSSL has zlib
In-Reply-To: <20050904170025.GA17528@...33...>
References: <423638938.20050903211124@...450...>
 <20050904170025.GA17528@...33...>
MIME-Version: 1.0
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
Date: Sun Sep  4 11:14:14 2005
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hello Matthias,

Sunday, September 4, 2005, 9:00:25 PM, you wrote:
>>   What if I port lzo too and use it for OpenVPN configuration?
>>   I will still have to link with the zlib, but which compression the
>>   OpenVPN daemon will use if lzo is enabled in it's configuration?
MA> If OpenSSL wants zlib, you need to link with it, no matter if LZO is
MA> there or not. LZO is a different compression, not compatible with zlib.
May be my question was not clear enough...
I wonder what compression will be in effect if both OpenSSL has zlib
and OpenVPN has lzo.
Which compressor will act upon the traffic? Both? Either or neither?
That is to ask if I really need porting lzo when zlib compresses
tighter and OpenVPN is smart enough not to try compress already
compacted data. (Or, OpenSSL will use zlib on TLS handshake etc, while
OpenVPN will use lzo for the user-data and so there will be some
advantage gained?)

-- 
Best regards,
 Tony.                mailto:mts.spb.suxx@...450...


