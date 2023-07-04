Message-ID: <61fca68d-7558-7366-476d-651886eaa7e3@...1227...>
Date: Tue, 4 Jul 2023 13:43:58 +0200
MIME-Version: 1.0
From: Arne Schwabe <arne@...1227...>
References: <9160f6a3-1a61-d112-7a48-a7da4af38644@...2108...>
Content-Language: en-GB
In-Reply-To: <9160f6a3-1a61-d112-7a48-a7da4af38644@...2108...>
Subject: Re: [Openvpn-devel] OpenVPN Linking Exception - current status
 report update July
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

Since the last update, we resolved the license approval for a number of 
contributors and are now down to just


Note that the actions for the individual source are my opinion/suggestions.

- Jason A. Donenfeld <Jason@...2390...>

   - Patches to remove possible contribution on mailing list

- James Bottomley <James.Bottomley@...2316...>

     No response to my license email, however was active this year on 
the mailing list.

     * Add unit tests for engine keys
     * engine key support

     This commits are only relevant for OpenSSL 1.x and we can probably
     remove support for this feature again if James does not positively.

- Jérémie Courrèges-Anglas <jca@...2272...>

    - raised the question if we can keep the OpenSSL license exception
      forever to keep LibreSSL support. I think that is reasonable to just
      keep the outdated exception even if it is just for a handful of
      people using OpenVPN with LibreSSL. When we drafted the mails we
      proposed to remove this because we overlooked LibreSSL.

     * Print time_t as long long and suseconds_t as long
	probably not trivial.
     * Rest of the commits look very small and can probably classified 
as     trivial

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





Arne


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

