References: <CAKh=nwF5PZ2CbEARe7-D=0dxt-XjRR-+2Z=16pENVzzxfgZM8A@...278...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <707c4845-6d3b-e9ba-0e8a-36f27d85bab3@...1856...>
Date: Mon, 1 Jan 2018 16:36:15 +0100
MIME-Version: 1.0
In-Reply-To: <CAKh=nwF5PZ2CbEARe7-D=0dxt-XjRR-+2Z=16pENVzzxfgZM8A@...278...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] PKCS#11 - a little bit of help?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 01-01-18 14:57, Emmanuel Deloget wrote:
> I'm trying to get openvpn read my certificates from a TPM2 using a
> specially crafted PKCS#11 provider (the existing tpm2-pk11 is quite
> limited for now but I might be able to extend it). 
> 
> However, the PKCS#11 API is not something I'm comfortable with, and I'd
> like to know if there is some document (design or anything, really) that
> could help me to understand what openvpn wants exactly in order for me
> to provide the missing bits. I've read the documents at [1] but found
> nothing here of interest (for me). 
> 
> So, does someone have any pointer?

You're right that OpenVPN's pkcs11 options lack some high-level
documentation.  Maybe I can shed some light on the basics (probably
taking a step further back than you need).

First, you need some shared object (.so, .dll) that provides the
interface specified by the PKCS11 standard.  OpenVPN will load that
module, and call its functions to provide private key operations.  That
shared object is usually provided by your smartcard vendor.  That shared
object takes care of communication with the underlying key store (smart
card, tpm, hsm, ...).  The openvpn manpage calls this a pkcs11 'provider'.

$ openvpn --show-pkcs11-ids
/usr/lib/x86_64-linux-gnu/pkcs11/gnome-keyring-pkcs11.so

The following objects are available for use.
Each object shown below may be used as parameter to
--pkcs11-id option please remember to use single quote mark.

Certificate
       DN:             C=KG, ST=NA, O=OpenVPN-TEST, CN=Test-Client,
emailAddress=me@...430...
       Serial:         02
       Serialized id:
Gnome\x20Keyring/1\x2E0/1\x3AUSER\x3ADEFAULT/Gnome2\x20Key\x20Storage/1A9D824585217F1BD54603E83F042F570A2EE9F2

(I have the openvpn client testkey in my local gnome keyring, to easily
test pkcs11 without a hardware token.)

From that list, you pick the object you want to use, and specify the
provider and id in your config file.  In this case:

pkcs11-providers "/usr/lib/x86_64-linux-gnu/pkcs11/gnome-keyring-pkcs11.so"
pkcs11-id
"Gnome\\x20Keyring/1\\x2E0/1\\x3AUSER\\x3ADEFAULT/Gnome2\\x20Key\\x20Storage/1B3B2BEBF36576443D3A903AFA8997221B93FCC1"

You specify this *instead* of the regular 'key' and 'cert' options.
Note that you'll need toe escape backslashes.

You should now be able to use pkcs11 for the private key operations.

Since each keystore behaves differently, I did not specify how to get
the private key in there.  But I guess your TPM vendor providers tooling
for that.

Hope this helps,
-Steffan

