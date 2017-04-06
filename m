References: <6b3b8a029cd8761642ac3f8174238aa2.squirrel@...2260...>
	<063244418e0b88138db5b490037cb7a4.squirrel@...2257...>
	<267890da-2186-dddb-d4c4-d6374da7e086@...277...>
	<049b9d27-d6a4-41cf-9742-bed02b2cc39b@...2080...>
	<18a96a72-4778-22b3-8a57-ce87d3f7060b@...2080...>
	<11253b26-cb11-8b7a-02e0-d5b1ad89e199@...277...>
	<2465b076-35e8-6144-f1b8-085ad5a016f0@...277...>
	<e09e9fbc1ce629510c439bbc06569b1a.squirrel@...2260...>
	<f6a87e19-4ac0-4ea2-69f3-2f424cbe8891@...1227...>
	<86ef0241-5144-206a-4691-6713434fdaa4@...277...>
	<20170405204236.GM93896@...1296...>
	<ec5b45716d7fad0f492b19e6c54b82fe.squirrel@...2260...>
	<e6e53a2e-55ff-656d-4eb1-1c4a31403dbc@...2080...>
From: debbie10t <debbie10t@...277...>
Message-ID: <e212b2d7-9f6c-db82-b3be-5c51bb5fb972@...277...>
Date: Thu, 6 Apr 2017 12:30:32 +0100
MIME-Version: 1.0
In-Reply-To: <e6e53a2e-55ff-656d-4eb1-1c4a31403dbc@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2] Add per session pseudo-random
 component to --reneg-sec intervals
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
To: openvpn-devel@lists.sourceforge.net



On 06/04/17 11:26, David Sommerseth wrote:

> With the 1 hour default, not setting --reneg-sec gives a time window of
> 6 minutes with 10%.  That is a reasonable default unless explicitly
> overridden by either --reneg-sec 3600 (no randomness) or --reneg-sec
> 3000 4000 (with a 1000 seconds large time window)

I still believe this approach is wrong.

You are changing the meaning of an operand depending on the number of 
operands and changing the function of the directive depending on number
of operands and if the directive is explicitly specified or not.

This is equivalent to:

(no --server specified) = --server 10.8.0.0 255.255.255.0
vs
--server subnet mask (pool determined by default)
vs
--server *pool* subnet mask

And so I re-submit my protest!

The syntax for --reneg-sec should be "--reneg-sec seconds window"

where "--reneg-sec 3600" is as it is now !
where "--reneg-sec 3600 360" is as now with a 10% window of random.

Not specifying --reneg-sec at all should *not* imply a default window,
it should remain as it is now.

Additionally, "window" *could* be + or - allowing for window to be 
applied at the beginning of the session or at the end of the session.

Also, IMO this should be first-run *only*

I am sorry David but you have not changed my mind,
although the decision is, of course, down to the devs.

my2c
regards

