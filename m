MIME-Version: 1.0
References: <1581519967-16950-1-git-send-email-selva.nair@...277...>
 <202002131954.01DJsIrb090643@...2054...>
 <20200415175828.GK1431@...1296...>
In-Reply-To: <20200415175828.GK1431@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 15 Apr 2020 14:22:15 -0400
Message-ID: <CAKuzo_gXcXxbKuQ-7GK54H6GBvOYCd0xrF2g0ry9=DZ5MUtsQA@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Skip expired certificates
 in Windows certificate store
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

> is this one and aa6affe6df811db11577847366a569def0a3e314 also material
> for release/2.4?  So "feature" or "bug" category?

Yes it would be good to get this one and aa6affe into 2.4. This one
will cherry-pick with a minor conflict in cryptoapicert.c, easily
resolved. aa6affe should cherry-pick with no issues.

Selva

