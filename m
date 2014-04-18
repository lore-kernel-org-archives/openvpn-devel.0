Message-ID: <535136F5.6080406@...1435...>
Date: Fri, 18 Apr 2014 16:30:13 +0200
From: Steffan Karger <steffan.karger@...1435...>
MIME-Version: 1.0
References: <20140413152613.GT16637@...1296...>	<20140414193422.GN16637@...1296...>	<534C42AB.7040700@...1114...>	<20140415074239.GR16637@...1296...>
	<20140416152456.GI16637@...1296...>
In-Reply-To: <20140416152456.GI16637@...1296...>
Subject: Re: [Openvpn-devel] RFD: ssl library version numbers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 04/16/2014 05:24 PM, Gert Doering wrote:
> OK, here's the full patch with this version.

One minor remark: if you add an extra * to the /* of the comment above
get_ssl_library_version(void), the comment becomes a doxygen comment and
will be included in the generated doxygen.

Otherwise, ACK.

-Steffan


