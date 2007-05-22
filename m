Message-ID: <9e0cf0bf0705220059k67174b6arc0d35a3cdad1dcca@...278...>
Date: Tue, 22 May 2007 10:59:16 +0300
From: "Alon Bar-Lev" <alon.barlev@...277...>
In-Reply-To: <20070522074947.GE1539@...172...>
MIME-Version: 1.0
References: <20070516135709.GE26428@...172...>
	<20070516145917.GC36293@...1026...>
	<20070520231131.GB19461@...172...>
	<9e0cf0bf0705202145r2ea770cbh99e656ce630de45f@...278...>
	<20070521050705.GC19461@...172...>
	<9e0cf0bf0705211145r79d4c226g3eb24db31a55f3de@...278...>
	<20070522074947.GE1539@...172...>
Subject: Re: [Openvpn-devel] Smartcard Authentication
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: Alon Bar-Lev <alon.barlev@...277...>, Jochen Kaiser <Jochen.Kaiser@...1025...>, openvpn devel <openvpn-devel@lists.sourceforge.net>, Michael Gernoth <simigern@...172...>, Markus Friedl <Markus.Friedl@...1027...>

On 5/22/07, Thomas Glanzmann <thomas@...1029...> wrote:
> Actually I don't consider PKCS#11 a standard interface. It's more like
> everyone puts its binary blob anywhere. Actually I think it's horrible by
> design. It's more like a "standard" interface to a binary blob that does
> something that isn't standard with the actual smartcard. From what I
> heard and read about PKCS#11 it is a mess.

This say it all.
It seems you don't understand what standard is.
And because of people with the same attitude we don't have a valid
cryptography in open source.
I had this discussion over and over...
Everybody think he can do better, and we end up with unusable solutions.

A standard is a compromise between the best way to achieve a goal and
the interest of several parties.

I guess you are aware that you use PKCS#1, PKCS#8, PKCS#7 PKCS#12,
PKCS#10, all are not the best way to encode any format, but it makes
application communicate correctly with each-other. PKCS#11 falls on
the same category.

Because everybody think we knows better, we got to a state where the
user must execute about 5 agents on his computer to use his smartcard
(ssh-agent, gpg-agent, seahorse, gnutls and more). This is
unacceptable, and proves that there is nothing close to standard.

Best Regards,
Alon Bar-Lev.

