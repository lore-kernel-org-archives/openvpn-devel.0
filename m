Message-ID: <4DE504BA.6060209@...1030...>
Date: Tue, 31 May 2011 16:09:46 +0100
From: Mr Dash Four <mr.dash.four@...1030...>
MIME-Version: 1.0
References: <4DB864E0.4060207@...515...> <4DE4F116.2000904@...1030...>
	<4DE502D5.3070403@...1114...>
In-Reply-To: <4DE502D5.3070403@...1114...>
Subject: Re: [Openvpn-devel] OpenVPN 2.2.0 build failure
	with	"--disable-management"
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> Quick fix: add --disable-pkcs11 in addition to --disable-management
>
> Can you try to apply the attached patch?  I believe that might solve your
> compile issues.
>   
Many thanks - I think applying the patch would be easier (I'll just list 
it in the .spec file and include it during the rpm build) - I take it 
that would solve the above. I'll let you know when I try this later tonight.

