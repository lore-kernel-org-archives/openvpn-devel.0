References: <20170426160021.25122-1-davids@...515...>
	<29e6daf6-6423-5fb7-ff55-7710b528ddab@...1856...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <17cb07d7-0071-721b-7529-308080bc89b2@...1856...>
Date: Wed, 3 May 2017 22:23:02 +0200
MIME-Version: 1.0
In-Reply-To: <29e6daf6-6423-5fb7-ff55-7710b528ddab@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] crypto: Enable SHA256 fingerprint
 checking in --verify-hash
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net


On 03-05-17 22:15, Steffan Karger wrote:
> On 26-04-17 18:00, David Sommerseth wrote:
>> In addition it moves the hash verification away from memcmp() to
>> memcmp_constant_time().  And slightly it enhances the layout of the
>> --verify-hash section in the man page.
> 
> Hashes are public, so there is no real need to use
> memcmp_constant_time() here.  It doesn't hurt either though - so I won't
> complain further if you prefer to keep it ;-)

Hrmpf, on sending I realize this is not the right argument.

Public doesn't matter (MACs are public too), what matters is that we are
not comparing attacker input (a MAC), but the calculated hash of
attacker input (the hash of the supplied cert).  As long as the hash
function is preimage resistant, we don't have to do constant time
comparison.  (And SHA1/SHA256 and even MD5 are pre-image resistant.)

Hashing the inputs and comparing the hashes actually is one of the
options to do a constant time memcmp :-)

-Steffan

