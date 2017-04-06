Message-ID: <dce27d0cf8706573764cabd315d078d6.squirrel@...2257...>
In-Reply-To: <f92fad68-1c19-d647-61ad-5926e5fdf6c8@...2080...>
References: <6b3b8a029cd8761642ac3f8174238aa2.squirrel@...2260...>
	<267890da-2186-dddb-d4c4-d6374da7e086@...277...>
	<049b9d27-d6a4-41cf-9742-bed02b2cc39b@...2080...>
	<18a96a72-4778-22b3-8a57-ce87d3f7060b@...2080...>
	<11253b26-cb11-8b7a-02e0-d5b1ad89e199@...277...>
	<2465b076-35e8-6144-f1b8-085ad5a016f0@...277...>
	<e09e9fbc1ce629510c439bbc06569b1a.squirrel@...2260...>
	<f6a87e19-4ac0-4ea2-69f3-2f424cbe8891@...1227...>
	<86ef0241-5144-206a-4691-6713434fdaa4@...277...>
	<20170405204236.GM93896@...1296...>
	<31b0e79c-99b3-0372-8e47-762dbc3990d7@...277...>
	<93f91c48-94cb-c421-3f06-d7d76eb58511@...2080...>
	<CAFHpkQFqq2HEdqeQL+f4W_vQtvuVswOVP9tXcoPPTU4=LMtYUw@...278...>
	<4f6776e3-3b9b-fae4-339c-6f28b6a24b1e@...2080...>
	<CAFHpkQFhSAMWDduU2VuRkLDrWiXh0jhVQyTBZrNG8i59BK6EPA@...278...>
	<f92fad68-1c19-d647-61ad-5926e5fdf6c8@...2080...>
Date: Thu, 6 Apr 2017 15:18:21 +0200
From: "Simon Matter" <simon.matter@...2249...>
MIME-Version: 1.0
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

> Web servers these days are also multi-threaded (or "multi-forked"), so
> they can utilize multiple cores more efficiently.  OpenVPN is *single
> threaded*.  So when one client starts a TLS renegotiation, it blocks all
> the other connected clients until the renegotiation have completed.
> When you then have 100 connected clients spending 1-2 seconds on each
> renegotiation happening at the same time, you will have 100-200 seconds
> of slow and lagging VPN tunnel.  This does not mean that you will see a
> CPU spike, as each client is handled serialized (one by one) - not in
> parallel.

That's only true for single instance servers, with multiple OpenVPN
instances and limited CPU cores this quickly becomes an issue.

Simon


