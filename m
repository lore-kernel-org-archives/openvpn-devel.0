Message-ID: <4174B824.3090905@...292...>
From: "Peter 'Luna' Runestig" <peter+openvpn@...292...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] PATCH[1/2]: Use certificates from MS Cert Store
 with CryptoAPI
References: <twig.1098084812.36872@...41...> <417420A6.9090200@...292...> <Pine.LNX.4.58.0410181410180.28940@...269...>
In-Reply-To: <Pine.LNX.4.58.0410181410180.28940@...269...>
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
Date: Mon Oct 18 23:47:12 2004
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net

On 2004-10-18 22:13, James Yonan wrote:
> On Mon, 18 Oct 2004, Peter 'Luna' Runestig wrote:
> 
>> On 2004-10-18 09:33, James Yonan wrote:
>> > I've merged the MSVC patch for beta12,
>> 
>> Hmm, what exactly did you merge? I can't see much trace of it...
> 
> I merged the first patch only, the one that lets OpenVPN build on MSVC.

Yes, I understand. Looking closer now, I see that the changes to
error.h, otime.c and tun.c is applied, but not the changes to
config-win32.h or the new file makefile.w32-vc.

-- 
Peter 'Luna' Runestig (fd. Altberg), Sweden <peter@...292...>
PGP Key ID: 0xD07BBE13
Fingerprint: 7B5C 1F48 2997 C061 DE4B  42EA CB99 A35C D07B BE13
AOL Instant Messenger Screen name: PRunestig
Yahoo! Messenger profile name: altberg

