Message-ID: <5670890D.7050501@...1147...>
Date: Tue, 15 Dec 2015 22:41:33 +0100
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <1450123758-31641-1-git-send-email-steffan@...1856...>	<566F5B01.8020109@...2080...>
	<20151215075312.GN24952@...1296...>
In-Reply-To: <20151215075312.GN24952@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Warn user if their certificate has
	expired
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Hi,

On 15/12/15 08:53, Gert Doering wrote:
> Hi,
>
> On Tue, Dec 15, 2015 at 01:12:49AM +0100, David Sommerseth wrote:
>> Just tried to build openvpn on one of my laptops (Scientific Linux 7.1,
>> openssl-1.0.1e-42.el7).  And it explodes when reaching the
>> SSL_CTX_get0_certificate(), it seems that support arrived in OpenSSL 1.0.2?
>> Could that be right?  Haven't had brainpower yet to dig deeper.
> Yeah, we noticed.  Sorry for that.  Never seen so much red on the buildbot
> list before... :-)
>
> Committed and pushed the "not before 1.0.2" workaround.
>
>
hmmmm I think this feature is actually worth adding to systems based on 
OpenSSL 1.0.1 as well (think RHEL 7 etc). The problem is, the current 
fix is very 1.0.2 specific and there seems to be no easy work-around.
Another approach is to check the certificate expiry time when the cert 
is loaded, but - as Steffan pointed out - this would mean that multiple 
places need a function call to check this:
- when loading an x509 file
- when loading a pkcs12 file
- when loading an inline blob
- when loading something from pkcs11
- when loading something via cryptostore
- when loading something using the management interface

the problem lies in the 'reachability' of the actual X509 certificate 
structure in OpenSSL
- the SSL_CTX context contains the X509 cert, but you cannot get at it 
until 1.0.2
- at connection time the SSL struct also contains it, but this is too 
late in the process.

I'm inclined to alter the patch to check it at all items listed above - 
what do you guys think?
Having to wait for openssl 1.0.2 (which even my fedora 22 box does not 
yet have) seems a bit like "so close, yet so far ..."

JJK



