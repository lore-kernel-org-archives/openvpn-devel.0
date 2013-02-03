Message-ID: <510E43DE.20008@...1147...>
Date: Sun, 03 Feb 2013 12:02:54 +0100
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
Subject: [Openvpn-devel] option --crl-verify PATH dir
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

hi,

what is the second option to '--crl-verify' supposed to do? in options.c 
it sets a flag SSLF_CRL_VERIFY_DIR which then triggers the function 
'verify_check_crl_dir'. However, this function does not seem to do 
anything....

see you in a moment,

JJK


