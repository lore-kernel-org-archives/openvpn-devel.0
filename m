References: <1449599329-12968-1-git-send-email-wayne@...2099...>
	<1449599329-12968-2-git-send-email-wayne@...2099...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <5669A816.70603@...1227...>
Date: Thu, 10 Dec 2015 17:28:06 +0100
MIME-Version: 1.0
In-Reply-To: <1449599329-12968-2-git-send-email-wayne@...2099...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Fix CR prompt with --auth-user-pass
 & support reading response.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Wayne Davison <wayne@...2099...>, openvpn-devel@lists.sourceforge.net



Am 08.12.15 um 19:28 schrieb Wayne Davison:
> Fixes a bug where there is no prompt for a dynamic (or static) challenge
> response when combining "--auth-retry interact" (or --static-challenge)
> with --auth-user-pass and the password is read from the file. It also
> extends the reading from the file to allow a response to be provided on
> the line after the password (which is nice for "push", "phone", etc.).
>
> NOTE: indentation left too deep on one big section so that changes are
> clearly seen.
Could you describe the scenario this patch fixes? The dynamic and static
challenge protocol are enabled if also the management interface is enabled.

The scenario read the password from file and then ask the password per
console seems a bit strange.

Arne

