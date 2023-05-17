Message-ID: <1d6d0f35-26e6-5791-ab7f-d5ec0ac04628@...1227...>
Date: Wed, 17 May 2023 15:01:38 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <9160f6a3-1a61-d112-7a48-a7da4af38644@...2108...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <9160f6a3-1a61-d112-7a48-a7da4af38644@...2108...>
Subject: Re: [Openvpn-devel] OpenVPN Linking Exception - current status
 report
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Am 15.02.23 um 13:31 schrieb David Sommerseth:
> 
> OpenVPN 2.x is licensed under the GNU Public License v2.0 (GPL-2.0). 
> This license has served us well in the past and we are not trying to 
> change that.  However, changes in licenses of our dependencies put us in 
> an unfortunate situation.

So a good amount of time has passed and we got a lot of positive 
feedback to the license agreement. We got 107 positive responses back 
contributors including a positive one from Fox IT that covers all Fox It 
employers and a positive one from OpenVPN Inc that cover all code that 
OpenVPN Inc owns. And big thanks to everyone who said yes so far.


With that we are down to a small number of people (10) that are still 
missing acknowledgment.


Note that the actions for the individual source are my opinion/suggestions.

- Jason A. Donenfeld <Jason@...2390...>

   Has stated to me in a private IRC message that I should bothering him
   about this. Only negative reaction so far.

   * Support fingerprint authentication without CA certificate

   The original v1 patch of this has been significantly rewritten/changed
   by me. We need to check which parts of the v3 patch that of the
   original patch can be still attributed to Jason and rewrite that part
   unless we still get a positive reaction.

- James Bottomley <James.Bottomley@...2316...>

    No response to my license email, however was active this year on the 
mailing list.

    * Add unit tests for engine keys
    * engine key support

    This commits are only relevant for OpenSSL 1.x and we can probably
    remove support for this feature again if James does not positively.

- Josh Cepek <josh.cepek@...1085...>

   No response at all to my emails. Commits were in 2013 and 2016

   All seven commits look trivial to me. Need someone else to form an 
opinion if this can be seen as trivial in total or not.


- Guido Vranken <guidovranken@...277...>

   No response at all to my emails. Commit are in 2017.

   - 7 smallish commit, not sure if they are trivial. Best to try to
     reach this person
   - might be part of some security audit, need to double check if there
     are some strings attached to that.

- Jérémie Courrèges-Anglas <jca@...2272...>

   - raised the question if we can keep the OpenSSL license exception
     forever to keep LibreSSL support. I think that is reasonable to just
     keep the outdated exception even if it is just for a handful of
     people using OpenVPN with LibreSSL. When we drafted the mails we
     proposed to remove this because we overlooked LibreSSL.

    * Print time_t as long long and suseconds_t as long
	probably not trivial.
    * Rest of the commits look very small and can probably classified as 
    trivial

- Andris Kalnozols <andris@...1839...>

   Address bounces, could not find any alternative method of contacting
   this person. three commits:

     * extract_x509_extension(): hide status message during normal 
operation.
     * Fix some typos in the man page.

	trivial

    * Do not upcase x509-username-field for mixed-case arguments.
       non-trivial needs more investigation.


- Mathieu GIANNECCHINI <mat.giann@...260...>

   Mail address bounces, could not find an alternative contact.
              --tls-export-cert option only

   One commit having the following feature:

   "--tls-export-cert [directory] : Get peer cert in PEM format and 
store it \n"
   "                  in an openvpn temporary file in [directory]. Peer 
cert is \n"
   "                  stored before tls-verify script execution and 
deleted after.\n"

    We can remove the feature, it seems a corner case. If someone needs
    it can still be reimplemented.

- Holger Kummert <Holger.Kummert@...1516...>

   Reached out to other ex-Sophos employees, will try to contact him.

   One commit bordering on trivial.


- Markus Koetter <koetter@...1432...>

   Email address bounces, found no alternative contact method. One 
commit in 2011

   Add extv3 X509 field support to --x509-username-field

   Needs --enable-x509-alt-username configure option to be enabled, not
   enabled by default.


- Vasily Kulikov <segoon@...2008...>

   No response so far. Would be probably good to check for alternative
   email address

   One trivial commit and

   * Mac OS X Keychain management client

    contrib/keychain-mcd already removed since it had code quality issues.

    Code for management-external-cert still in OpenVPN, is not trivial



Arne

