Message-ID: <435370A7.6030107@...474...>
From: Zhuang Yuyao <ihollo@...474...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] OpenVPN 2.1-beta3 released
References: <Pine.LNX.4.58.0510160652370.31752@...41...>
In-Reply-To: <Pine.LNX.4.58.0510160652370.31752@...41...>
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
Date: Mon Oct 17 02:38:48 2005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

line 914 in ssl.c should be changed from

if (options->ca_file)

to

if (options->ca_file || options->ca_path)


James Yonan wrote:

>Download:
>
>  
>



