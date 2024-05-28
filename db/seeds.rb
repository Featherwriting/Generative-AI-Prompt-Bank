# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

ActiveRecord::Base.transaction do
# delete every thing in db
    [Prompt, Issue, User, Tag, Example, Category, Admin].each do |model|
        model.destroy_all
    end
end

# Create tags in db
# tag1 = Tag.create(name: "Tag1")
# tag2 = Tag.create(name: "Tag2")

# Create categories in db
category_roles = Category.create(name: "Roles", purpose: "To identify the specific way in which you would like the GenAI tool to perform the function.")
category_limitations = Category.create(name: "Limitations", purpose: "Set out how you would like the output to be presented.")
category_background_research = Category.create(name: "Background research", purpose: "To explore an area of interest to open up avenues for further research.")
category_being_critical = Category.create(name: "Being critical", purpose: "To understand and evaluate the strengths and weaknesses of a range of different perspectives on a topic.")
category_understanding_complex_theories_and_concepts = Category.create(name: "Understanding complex theories and concepts", purpose: "To break down a complex concept into a more accessible format.")
category_structure = Category.create(name: "Structure", purpose: "To gain constructive feedback on the structure and organization of a piece of writing.")
category_use_of_academic_language = Category.create(name: "Use of academic language", purpose: "To gain constructive feedback on the accuracy and register of language in a piece of writing.")
category_use_of_sources = Category.create(name: "Use of sources", purpose: "To gain constructive feedback on the use of evidence to support an argument or claim.")
category_exam_revision = Category.create(name: "Exam revision", purpose: "To assess overall knowledge of a topic as part of exam preparation.")
category_productivity =  Category.create(name: "Productivity", purpose: "To support a range of everyday tasks.")
category_follow_on_prompting = Category.create(name: "Follow-on prompting", purpose: "To build a richer understanding of an area of interest.")


# Create issues in db
issue = Issue.create(name: "Accuracy", link: "https://www.sheffield.ac.uk/academic-skills/study-skills-online/genai-academic-prompt-bank#accuracy")

# Create examples in db
example = Example.create(link: "link")

#Create prompts in db
prompt_roles_1 = Prompt.create(prompt_content: "You are an expert in [xxx].", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_roles_2 = Prompt.create(prompt_content: "You are an English Language tutor.", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_roles_3 = Prompt.create(prompt_content: "You are communicating to a non-specialist audience.", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_roles_4 = Prompt.create(prompt_content: "You are writing for an academic audience.", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_roles_5 = Prompt.create(prompt_content: "You are an academic tutor on a university [subject] course.", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_limitations_1 = Prompt.create(prompt_content: "Provide a bullet point list.", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_limitations_2 = Prompt.create(prompt_content: "Provide a numbered list.", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_limitations_3 = Prompt.create(prompt_content: "Provide a summary in no more than 500 words.", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_limitations_4 = Prompt.create(prompt_content: "Provide an output in prose form in no more than five paragraphs.", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_limitations_5 = Prompt.create(prompt_content: "Present an output in the form of a series of questions and answers.", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_limitations_6 = Prompt.create(prompt_content: "Avoid using the first person.", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_background_research_1 = Prompt.create(prompt_content: "Trace the historical development of [concept/idea] and examine its contemporary significance.", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_background_research_2 = Prompt.create(prompt_content: "Compare and contrast [two or more theories/models] in [subject], highlighting their strengths and weaknesses.", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_background_research_3 = Prompt.create(prompt_content: "Explore the impact of [significant innovation or discovery] on [industry/field], considering both short-term and long-term effects.", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_background_research_4 = Prompt.create(prompt_content: "Analyse the social and cultural implications of [specific event/development] and its influence on society.", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_background_research_5 = Prompt.create(prompt_content: "Examine the intersection of [subject] and [another discipline], exploring how insights from one field can inform the other.", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_background_research_6 = Prompt.create(prompt_content: "Conduct a detailed analysis of [work of literature, art, film, etc.], exploring themes, symbolism, and artistic techniques.", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_background_research_7 = Prompt.create(prompt_content: "Explore recent innovations and breakthroughs in [industry/field], discussing their impact and potential implications for the future.", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_being_critical_1 = Prompt.create(prompt_content: "Provide a range of critical perspectives on the following claim: [claim or argument]", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_being_critical_2 = Prompt.create(prompt_content: "Identify and critically discuss the weaknesses or limitations of [insert theory or argument], considering alternative perspectives.", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_being_critical_3 = Prompt.create(prompt_content: "Identify real-world applications of the [theories/models] in [subject], and assess their effectiveness.", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_being_critical_4 = Prompt.create(prompt_content: "Investigate controversies associated with [innovation/discovery] and explore their implications for potential future developments in the field.", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_being_critical_5 = Prompt.create(prompt_content: "Provide a range of cultural perspectives on [event/development], considering regional and local variations in attitudes, values, and beliefs.", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_being_critical_6 = Prompt.create(prompt_content: "Explore case studies or examples where the intersection of [subject] and [another discipline] has led to innovative solutions or advancements.", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_being_critical_7 = Prompt.create(prompt_content: "Investigate the potential challenges and obstacles hindering the widespread adoption of [the identified innovations] in [industry/field].", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_being_critical_8 = Prompt.create(prompt_content: "Provide critical counterpoints to [argument/idea] and explore how they have contributed to current thinking.", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_understanding_complex_theories_and_concepts_1 = Prompt.create(prompt_content: "Break down the fundamental concepts of [insert theory] in a way that someone without a background in the field can understand.", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_understanding_complex_theories_and_concepts_2 = Prompt.create(prompt_content: "Provide a summary of [insert theory] identifying five key points that I need to be aware of and why.", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_understanding_complex_theories_and_concepts_3 = Prompt.create(prompt_content: "Use a common analogy or metaphor to explain the concept of [insert theory] and its significance.", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_understanding_complex_theories_and_concepts_4 = Prompt.create(prompt_content: "Provide a step-by-step breakdown of the key components of [insert theory] to guide a beginner through understanding the concept.", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_understanding_complex_theories_and_concepts_5 = Prompt.create(prompt_content: "Describe a real-world scenario or application where [insert theory] can be observed or applied, using plain language.", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_understanding_complex_theories_and_concepts_6 = Prompt.create(prompt_content: "Compare [insert theory] to a well-known concept in a different field to highlight similarities and differences.", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_understanding_complex_theories_and_concepts_7 = Prompt.create(prompt_content: "Break down the cause-and-effect relationships within [insert theory] to illustrate how certain factors lead to specific outcomes.", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_understanding_complex_theories_and_concepts_8 = Prompt.create(prompt_content: "Identify common misconceptions about [insert theory] and clarify them in simple terms, ensuring a better understanding of the concept.", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_structure_1 = Prompt.create(prompt_content: "Evaluate the clarity of the overall structure and organization of the following extract. Are the main ideas presented in a logical and coherent manner?: [insert extract of your work]", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_structure_2 = Prompt.create(prompt_content: "Assess the strength and clarity of the following introduction and thesis statement: [insert extract of your work]", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_structure_3 = Prompt.create(prompt_content: "Is the main argument [insert argument] effectively supported throughout the essay?: [insert extract of your work]", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_structure_4 = Prompt.create(prompt_content: "Examine the use of evidence to support key points in the following extract. Are the sources credible, relevant, and well-integrated into the argument?: [insert extract of your work]", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_structure_5 = Prompt.create(prompt_content: "Evaluate the quality of the conclusion in terms of its effectiveness in summarizing and synthesising the main points and provoking further reflection on the topic: [insert extract of your work]", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_use_of_academic_language_1 = Prompt.create(prompt_content: "Assess the clarity of language and expression. Are concepts and ideas communicated in a way that is easily understandable?: [insert extract of your work]", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_use_of_academic_language_2 = Prompt.create(prompt_content: "Evaluate the academic style and tone of the writing and provide constructive feedback on areas for possible improvement: [insert extract of your work]", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_use_of_academic_language_3 = Prompt.create(prompt_content: "Review the paper for grammatical and punctuation errors. Are there issues with spelling, grammar, or syntax that need attention?: [insert extract of your work]", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_use_of_sources_1 = Prompt.create(prompt_content: "Provide feedback on the synthesis of literature within the following piece of writing?: [insert extract of your work]", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_use_of_sources_2 = Prompt.create(prompt_content: "Evaluate the depth of engagement with existing literature in the following piece of writing: [insert extract of your work]", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_use_of_sources_3 = Prompt.create(prompt_content: "Does the author demonstrate awareness of relevant research and theoretical frameworks in the following piece of writing?: [insert extract of your work]", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_use_of_sources_4 = Prompt.create(prompt_content: "Are claims and arguments properly supported by evidence in the following piece of writing?: [insert extract of your work]", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_use_of_sources_5 = Prompt.create(prompt_content: "Identify any gaps or limitations in the use of sources in the following piece of writing: [insert extract of your work]", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_exam_revision_1 = Prompt.create(prompt_content: "Provide a series of short answer exam questions to test my knowledge of [topic]. Provide one question at a time, wait for my answer, provide feedback, then move onto the next question.", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_exam_revision_2 = Prompt.create(prompt_content: "Create a series of flashcards to test my knowledge of [topic].", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_exam_revision_3 = Prompt.create(prompt_content: "Break down [topic] into a series of short, memorable key points.", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_exam_revision_4 = Prompt.create(prompt_content: "I am revising for an [undergraduate-level/postgraduate-level] exam in [topic]. What are the key areas that I will need to focus on in my revision?", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_exam_revision_5 = Prompt.create(prompt_content: "Generate a mnemonic to help me to remember [topic].", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_exam_revision_6 = Prompt.create(prompt_content: "Use my notes to create a revision timetable ahead of an exam on [date].", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_productivity_1 = Prompt.create(prompt_content: "Evaluate the tone of this email.", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_productivity_2 = Prompt.create(prompt_content: "Identify the main actions arising from this email.", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_productivity_3 = Prompt.create(prompt_content: "Redraft this text adopting a more formal tone.", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_productivity_4 = Prompt.create(prompt_content: "I'm going to a lecture/seminar on [topic]. Give me a list of five important concepts that I need to be prepared for.", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_follow_on_prompting_1 = Prompt.create(prompt_content: "Where can I find more data on [specific topic]?", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_follow_on_prompting_2 = Prompt.create(prompt_content: "Expand on the [third] point with more specific detail.", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_follow_on_prompting_3 = Prompt.create(prompt_content: "Provide some case studies to illustrate these points.", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_follow_on_prompting_4 = Prompt.create(prompt_content: "Provide some specific examples to illustrate these points.", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_follow_on_prompting_5 = Prompt.create(prompt_content: "Provide some recent published academic sources for each of these points.", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_follow_on_prompting_6 = Prompt.create(prompt_content: "Provide counter arguments for each of these points.", stat: 1, submitter_email: "createdbydb", use_count: 0)
prompt_follow_on_prompting_7 = Prompt.create(prompt_content: "Identify which views may not be as fully represented in this response and why.", stat: 1, submitter_email: "createdbydb", use_count: 0)

# assigning the variables into the db
# prompt.tags << tag1 << tag2
# prompt.issues << issue

# Assign prompts to their respective categories
category_roles.prompts << prompt_roles_1 << prompt_roles_2 << prompt_roles_3 << prompt_roles_4 << prompt_roles_5
category_limitations.prompts << prompt_limitations_1 << prompt_limitations_2 << prompt_limitations_3 << prompt_limitations_4 << prompt_limitations_5 << prompt_limitations_6
category_background_research.prompts << prompt_background_research_1 << prompt_background_research_2 << prompt_background_research_3 << prompt_background_research_4 << prompt_background_research_5 << prompt_background_research_6 << prompt_background_research_7
category_being_critical.prompts << prompt_being_critical_1 << prompt_being_critical_2 << prompt_being_critical_3 << prompt_being_critical_4 << prompt_being_critical_5 << prompt_being_critical_6 << prompt_being_critical_7 << prompt_being_critical_8
category_understanding_complex_theories_and_concepts.prompts << prompt_understanding_complex_theories_and_concepts_1 << prompt_understanding_complex_theories_and_concepts_2 << prompt_understanding_complex_theories_and_concepts_3 << prompt_understanding_complex_theories_and_concepts_4 << prompt_understanding_complex_theories_and_concepts_5 << prompt_understanding_complex_theories_and_concepts_6 << prompt_understanding_complex_theories_and_concepts_7 << prompt_understanding_complex_theories_and_concepts_8
category_structure.prompts << prompt_structure_1 << prompt_structure_2 << prompt_structure_3 << prompt_structure_4 << prompt_structure_5
category_use_of_academic_language.prompts << prompt_use_of_academic_language_1 << prompt_use_of_academic_language_2 << prompt_use_of_academic_language_3
category_use_of_sources.prompts << prompt_use_of_sources_1 << prompt_use_of_sources_2 << prompt_use_of_sources_3 << prompt_use_of_sources_4 << prompt_use_of_sources_5
category_exam_revision.prompts << prompt_exam_revision_1 << prompt_exam_revision_2 << prompt_exam_revision_3 << prompt_exam_revision_4 << prompt_exam_revision_5 << prompt_exam_revision_6
category_productivity.prompts << prompt_productivity_1 << prompt_productivity_2 << prompt_productivity_3 << prompt_productivity_4
category_follow_on_prompting.prompts << prompt_follow_on_prompting_1 << prompt_follow_on_prompting_2 << prompt_follow_on_prompting_3 << prompt_follow_on_prompting_4 << prompt_follow_on_prompting_5 << prompt_follow_on_prompting_6 << prompt_follow_on_prompting_7

issue_accuracy = Issue.create(name:"Accuracy",link:"https://www.sheffield.ac.uk/academic-skills/study-skills-online/genai-academic-prompt-bank#accuracy")
issue_bias = Issue.create(name:"Bias",link:"https://www.sheffield.ac.uk/academic-skills/study-skills-online/genai-academic-prompt-bank#bias")
issue_simplification = Issue.create(name:"Simplification",link:"https://www.sheffield.ac.uk/academic-skills/study-skills-online/genai-academic-prompt-bank#simplification")
issue_unfair_means = Issue.create(name:"Unfair Means",link:"https://www.sheffield.ac.uk/academic-skills/study-skills-online/genai-academic-prompt-bank#unfair-means")
issue_intellectual_property = Issue.create(name:"Intellectual Property",link:"https://www.sheffield.ac.uk/academic-skills/study-skills-online/genai-academic-prompt-bank#intellectual-property")

issue_accuracy.prompts << Prompt.all
issue_bias.prompts << prompt_background_research_1 << prompt_background_research_2 << prompt_background_research_3 << prompt_background_research_4 << prompt_background_research_5 << prompt_background_research_6 << prompt_background_research_7
issue_bias.prompts << prompt_being_critical_1 << prompt_being_critical_2 << prompt_being_critical_3 << prompt_being_critical_4 << prompt_being_critical_5 << prompt_being_critical_6 << prompt_being_critical_7 << prompt_being_critical_8
issue_simplification.prompts << prompt_limitations_6 << prompt_background_research_1 << prompt_background_research_2 << prompt_background_research_3 << prompt_background_research_4 << prompt_background_research_5 << prompt_background_research_6 << prompt_background_research_7
issue_simplification.prompts << prompt_understanding_complex_theories_and_concepts_1 << prompt_understanding_complex_theories_and_concepts_2 << prompt_understanding_complex_theories_and_concepts_3 << prompt_understanding_complex_theories_and_concepts_4 << prompt_understanding_complex_theories_and_concepts_5 << prompt_understanding_complex_theories_and_concepts_6 << prompt_understanding_complex_theories_and_concepts_7 << prompt_understanding_complex_theories_and_concepts_8
issue_unfair_means.prompts << prompt_structure_1 << prompt_structure_2 << prompt_structure_3 << prompt_structure_4 << prompt_structure_5 << prompt_use_of_academic_language_1 << prompt_use_of_academic_language_2 << prompt_use_of_academic_language_3 << prompt_use_of_sources_1 << prompt_use_of_sources_2 << prompt_use_of_sources_3 << prompt_use_of_sources_4 << prompt_use_of_sources_5
issue_intellectual_property.prompts << prompt_exam_revision_6


tag = Tag.create(name:"ExampleTag")
tag.prompts << prompt_roles_1 << prompt_roles_2 << prompt_roles_3 << prompt_roles_4 << prompt_roles_5

example1 = Example.create(link:"https://gemini.google.com/share/19f0d3733de8")
prompt_roles_1.examples << example1
example2 = Example.create(link:"https://chat.openai.com/share/54b1a9bf-68c6-48c7-b3fe-432240a78d1d")
prompt_roles_3.examples << example2
example3 = Example.create(link:"https://g.co/bard/share/7ae195e37502")
prompt_background_research_1.examples << example3
example4 = Example.create(link:"https://chat.openai.com/share/0fc9ae61-e793-483b-b017-1a45522d8528")
prompt_background_research_5.examples << example4
example5 = Example.create(link:"https://g.co/bard/share/67712f1fb5e2")
prompt_being_critical_1.examples << example5
example6 = Example.create(link:"https://chat.openai.com/share/53929fa7-6060-4293-9ca1-d3add4e19bac")
prompt_being_critical_3.examples << example6
example7 = Example.create(link:"https://g.co/bard/share/19f0d3733de8")
prompt_being_critical_7.examples << example7

admin1 = Admin.create(admin_email: "hello@world.com", active_state: true)
manager = User.new(email: "jxu137@sheffield.ac.uk",is_manager: true)
manager.get_info_from_ldap 
manager.save

manager1 = User.new(email: "jbrice2@sheffield.ac.uk",is_manager: true)
manager1.get_info_from_ldap 
manager1.save

manager = User.new(email: "o.johnson@sheffield.ac.uk",is_manager: true)
manager.get_info_from_ldap 
manager.save
