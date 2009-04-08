Message-ID: <49DCC18D.6040509@...273...>
Date: Wed, 08 Apr 2009 11:23:57 -0400
From: Matt Wilks <matt@...273...>
MIME-Version: 1.0
References: <1239166995l.18482l.9l@...1207...>	<F9B005F620B74BD29BB0A36AF509BCED@...576...>
	<1239203062l.18482l.11l@...1207...>
In-Reply-To: <1239203062l.18482l.11l@...1207...>
Subject: Re: [Openvpn-devel] Unpackged Windows binaries? -- Problems
 building 2.1 rc15 on Windows XP
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
To: openvpn-devel@lists.sourceforge.net

Karl O. Pinc wrote:
> On 04/08/2009 07:58:12 AM, dave wrote:
>
> Yeah.  On Debian it just installs and seems to work.  But there must
> be more involved, somewhere, to have it go from source to nsis
> installer.

Is there a specific reason you are attempting to build the OpenVPN .exe
(are you trying to make a custom executable)?  You could just use a
compiled version (install in Windows, grab all the files), set up the
proper directory hierarchy and use NSIS to create a custom installer
package.  The NSIS stuff works under Linux.

-- 
Matt Wilks                   Colossians 2:6-7
University of Toronto        Computing and Networking Services
(416) 978-3328               matt@...273...
4 Bancroft Ave., Rm. 102     Toronto, ON  M5S 1C1

