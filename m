Message-ID: <9e0cf0bf0803161105u71b7afc0tc90fed05da57f0dc@...278...>
Date: Sun, 16 Mar 2008 20:05:10 +0200
From: "Alon Bar-Lev" <alon.barlev@...277...>
In-Reply-To: <47DD4B14.5060009@...1081...>
MIME-Version: 1.0
References: <47DD4B14.5060009@...1081...>
Subject: Re: [Openvpn-devel] patch pkcs11 dynamic key id detection
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: Christophe Vandeplas <christophe@...1081...>
Cc: Peter Koch <pk@...1082...>, openvpn-devel@lists.sourceforge.net, James Yonan <jim@...41...>

Hello,

I did not realize how many people depend on the low-level PKCS#11 properties.

I thought I prospone this to next OpenVPN version, but I see more an
more people need "single configuration file" option.

I first thought to create a filter similar to what you suggest... But
users would like to choose certificate based on certificate authority,
EKU, UPN or any other field, and OpenVPN is already complex enough.

Then I thought I would execute some external hook, but OpenVPN does
not have the ability to send large amount of data to hooks, and
receive data from hooks.

So back to my original idea... Use the management interface to prompt
the user to select a certificate.

You may find it at [1].

It introduces pkcs11-id-management configuration option and NEED-STR
real-time management message, that is responded with the PKCS#11
identity.

It also introduced two management commands: pkcs11-id-count, pkcs11-id-get.

The sequence is as follows:
>NEED-STR:Need 'pkcs11-id-request' string MSG:Please specify PKCS#11 id to use
pkcs11-id-count
>PKCS11ID-COUNT:5
pkcs11-id-get 0
>PKCS11ID-ENTRY:'0', ID:'<snip>', BLOB:'<snip>'
pkcs11-id-get 1
>PKCS11ID-ENTRY:'1', ID:'<snip>', BLOB:'<snip>'
needstr 'pkcs11-id-request' '<snip>'

This allows a management application to inspect available
certificates, and prompt the user to choose the correct one.

James, some notes:
1. Please acknowledge the NEED-STR addition. it is in the first revision.
2. I had to increase the USER_PASS_LEN constant, as it is also used
for strings now.
3. I had to increase the ERR_BUF_SIZE constant, as I need to output a
complete base64 certificate.

I hope this helps,
Alon Bar-Lev.

[1] svn diff -r 2844:2849
http://svn.openvpn.net/projects/openvpn/contrib/alon/BETA21/openvpn

On 3/16/08, Christophe Vandeplas <christophe@...1081...> wrote:
> Hi all,
>
>
>   From the mailinglist I'm not the first one that wanted dynamic key-id
>  detection for pkcs11 authentication.

