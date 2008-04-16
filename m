Date: Wed, 16 Apr 2008 11:16:07 -0700 (PDT)
From: Louis Luo <lluo_2wire@...109...>
MIME-Version: 1.0
Message-ID: <613570.80925.qm@...1089...>
Subject: [Openvpn-devel] deflate vs lzo
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi OpenVPN developers,


I am new to OpenVPN and have some questions regarding the compression algorithm and overall performance. Why was LZO here instead of other algorithms like deflate? Any particular performance consideration? 


I am lazy so didn't do any research regarding the difference and performance comparison between LZO and Deflate. Just hope to get a quick answer. If the question doesn't make sense, please forgive :-)


Another question is how much throughput OpenVPN can support, say, on a Gbits networks? I tested it in a 100Mbps LAN environment. Without LZO compression, I got around 50Mbps. With LZO enabled, the number is about 70Mbps, which is close to the rate I got without VPN. I am wondering, when LZO is not enabled, which part limits the throughput. The encryption/decryption? Or the TUN virtual device? I guess it's the encryption procedure so I hope to know the rate OpenVPN can get in a Gbits network. If anybody has some confirmed figure in mind, please kindly inform me. Thanks so much!


Best regards,


L.




      ____________________________________________________________________________________
Be a better friend, newshound, and 
know-it-all with Yahoo! Mobile.  Try it now.  http://mobile.yahoo.com/;_ylt=Ahu06i62sR8HDtDypao8Wcj9tAcJ

