References: <20191116102835.22883-1-arne@...1227...>
 <2ce5e07d-ac3d-4034-c2e1-56a00cb332bc@...2080...>
 <20200328113327.GO1431@...1296...>
 <172c2cf6-c27e-4b53-7867-83a01fb16b60@...2080...>
 <20200330055501.GT1431@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <958dec70-30ca-6583-5ddf-641c9d8ac739@...2181...>
Date: Mon, 30 Mar 2020 09:11:07 +0200
MIME-Version: 1.0
In-Reply-To: <20200330055501.GT1431@...1296...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Reformat all source files
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>, David Sommerseth <openvpn@...2080...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 30/03/2020 07:55, Gert Doering wrote:
>> Not sure now what would be the best approach forward. Picking the commit
>> contents from a rebased icsopenvpn branch would be one way (I can provide
>> commitish references I reviewed, if needed).  Another approach is for Arne to
>> resend rebased patches to ML.
> 
> Well, our current defined process is "we review, test and merge *exactly*
> what is on the list".
> 
> So, ACKing list patches based on "some other tree" is doubtful at best
> (for initial review and discussion, fine, but for the final ACK?), and
> "have something on the list and then merge something else" is also
> clearly violating the "everything must be transparent, and no code changes
> compared to what is archived in a public archive".
> 

I totally agree with Gert here.

> 
> We can change this, of course, but even then it needs to be fairly 
> transparent what was exactly was ACKed and merged (and what, if anything,
> was changed between ACK and merge).
> 

IMHO we should not change the process - git repos can go, while emails
remains in archives so it's possible to see the whole flow later in the
future.

IMHO the best course of action would be:
1. David reviewing the git branch
2. David privatelly talking to Arne and eventually saying "all patches
look good! I consider them ready for merging"
3. Arne sends the rebased patches to the mailing list
4. David checks that the patches are still the same he reviewed
5. David ACKs the patches on the mailing list in a public way.

I think this process would allow us to be super transparent and would
allow everybody to chime in until the very last minute.

The other upside is that point 1 and 2 can be repeated as much as needed
until David is satisfied, without spamming the ml.


my 2 cents.

Cheers,



-- 
Antonio Quartulli

