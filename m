References: <20210407191554.25811-1-maximilian.fillinger@...2507...>
 <E1lUDfq-000423-FN@...2487...>
 <72fe8d0a-1732-3c25-3050-abc54c606e4d@...2181...>
 <E1lURmY-0007Iz-Lc@...2608...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <872b5e93-bac0-54c6-016a-6ae85e6e2baa@...2181...>
Date: Thu, 8 Apr 2021 14:37:34 +0200
MIME-Version: 1.0
In-Reply-To: <E1lURmY-0007Iz-Lc@...2608...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 1/1] Rework mbedtls CRL handling
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Maximilian Fillinger <maximilian.fillinger@...2507...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi Max,

I was starting to comment to the various points in this email, but I
believe it was getting confusing.

Now that I have a better overview (thanks to your explanations!) I would
suggest splitting the problem in smaller sub-problems to help our
discussion.

[Later it'd be very nice to have one patch per problem being fixed too]


To the best of my understand we have the following problems that needs
fixing:
1) CRL being changed in-place, even though we may prefer not doing that;
2) --chroot messing up paths in pre- and post-chroot operations;
3) CRL not being used at all if OpenVPN failed to parse it during
initialization;
4) different CRL access/parsing errors handled differently.


Is the summary above correct? or is any of my points wrong/lacking details?


[If you prefer discussing on IRC, feel free to join #openvpn-devel on
freenode]


Regards,

-- 
Antonio Quartulli

