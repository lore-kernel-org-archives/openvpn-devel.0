Resent-To: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Resent-Message-ID: <d88f24a6-add4-7521-dba2-f441b32006a3@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
References: <d9c75727-f242-4c8a-3bfc-006e01629716@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <9d9305bf-b66c-d6bd-0a56-1ee5192d3b13@...2080...>
Date: Thu, 24 May 2018 21:38:27 +0200
MIME-Version: 1.0
In-Reply-To: <d9c75727-f242-4c8a-3bfc-006e01629716@...277...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [openvpn-devel] Use --ec-curve
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: tincanteksup <tincanteksup@...277...>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On 24/05/18 14:46, tincanteksup wrote:
> As --ec-curve remains undocumented I presume that is because its 
> implementation is not yet completed ? So I decided to send this email for
> confirmation or, if this problem is not known, to inform you of it.
openvpn (master) $ git grep ec-curve | wc -l
0
openvpn (release/2.4) $ git grep ec-curve | wc -l
0

It is correct that --ec-curve is not a valid option, thus not documented.
But you might be thinking of --ecdh-curve

openvpn (master) $ git grep ecdh-curve | wc -l
3
openvpn (release/2.4) $ git grep ecdh-curve | wc -l
3

And from the 2.4 man page:

       --ecdh-curve name
              Specify the curve to  use  for  elliptic
              curve  Diffie  Hellman. Available curves
              can be listed with  --show-curves.   The
              specified  curve  will  only be used for
              ECDH TLS-ciphers.

              This option is not supported in mbed TLS
              builds of OpenVPN.


Is this still unclear?


- -- 
kind regards,

David Sommerseth
OpenVPN Inc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJbBxSwAAoJEIbPlEyWcf3yQTEP/2dUhFMqIGy3TBppxBYyQaLK
vbvBipgHggV2DBp67X5r0YOX4Iw8q+xDDSCTKLd3hyzTx8zjsZE3TNAP+cZF3lqC
n/qmIlqYI4KSuPNtaypRaqUlJ8UMCdJZvpG6S/GQHEUYoR830ZQxJfIM++TvHOjv
1w/UnIMpqErEfUs9teaUx/oUscDoZgF2i7toCU/jXLDLIFQ/sS4v2pn62R5tmLs0
mS5L725HxLKWJBoyQA8awFnSJOU5fK0McReB+zpnW/7UjjsBuuLaVul+reRfLYQk
+2lLR9IhxpjF49kqOJPKeTmyQnE+6qBrLb8TgfMcqikRaH9sBtchdxkYyVqpCkNg
ri4SHwZ2OVzXceSsG0x0skt71EDlY8lit0wbpR6fbvXAoJ3aTCFGRN+zB6zlnkJ0
gJUaqewfaxaNLieEC+OQSCqtcWGXn05Wc+RRmsOJytcz8SQYl/Nk/EIFw14GmPBe
ensZXctHNGjqDN8nOeNz8RP63u0ub1HGH3Plb3L02CP7UW1bA1BSf3e5yUAHsAWm
+JlqA0BLuAWAnGeGwhR4pJa2KbXUX2WiRUECGxlLQMvGsRXySfMXYPLEzVhW2G4E
d4zr/+f8gVPXokwCNYSN4pc1rjgKStJVW8xtZjk4DWLQ3I60tAAcD6HOh+Bk92E8
eC7OW4nK6J1QWXTPiISc
=jJrO
-----END PGP SIGNATURE-----

